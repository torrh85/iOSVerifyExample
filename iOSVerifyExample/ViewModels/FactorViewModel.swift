//
//  FactorViewModel.swift
//  iOSVerifyExample
//
//  Created by Hawer Alberto Torres Castañeda on 6/02/21.
//

import Foundation
import TwilioVerify

public struct FactorViewModel {
    var identity: Identity
    var tokenApi = VerifyTokenAPI()
    var adapter = try? TwilioVerifyAdapter()

    public func fetchAccessToken(completion: @escaping (Result<Factor, Error>) -> Void) {
        print("Breadcrumb: Identity \(identity.id)")
        
        tokenApi.requestAccessToken(identity) { result in
            switch result {
                case .success(let accessToken): createFactor(accessToken: accessToken, completion: completion)
                case .failure(let error): completion(.failure(error))
            }
        }
    }
    
    private func createFactor(accessToken: AccessToken, completion: @escaping (Result<Factor, Error>) -> Void) {
        print("Breadcrumb: token \(accessToken.token)")
        print("Breadcrumb: serviceSid \(accessToken.serviceSid)")
        print("Breadcrumb: identity \(accessToken.identity)")
        print("Breadcrumb: factorType \(accessToken.factorType)")
        
        adapter?.createFactor(name: "MyFactor", accessToken: accessToken, completion: { result in
            switch result {
                case .success(let sid): verifyFacfor(sid, completion: completion)
                case .failure(let error): print("Unable to create factor \(error.localizedDescription)")
            }
        })
    }
    
    public func verifyFacfor(_ sid: String, completion: @escaping (Result<Factor, Error>) -> Void) {
        print("Breadcrumb: Veryfing factor... \(sid)")

        adapter?.verifyFactor(factorSid: sid, completion: completion)
    }
}
