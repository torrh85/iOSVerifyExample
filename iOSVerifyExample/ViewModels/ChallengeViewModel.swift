//
//  ChallengeViewModel.swift
//  iOSVerifyExample
//
//  Created by Hawer Alberto Torres Castañeda on 6/02/21.
//

import Foundation
import TwilioVerify

public struct ChallengeViewModel {
    var factor: Factor
    var challenge: Challenge?
    var registerApi = VerifyRegisterAPI()
    var adapter = try? TwilioVerifyAdapter()

    var challengeMessage: String {
        return "Message: \(challenge?.challengeDetails.message ?? "")"
    }
    
    var challengeDate: String {
        guard let challenge = challenge else { return "" }
        guard let date = challenge.challengeDetails.date else { return "" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"

        return "Date: \(formatter.string(from: date))"
    }
    
    var challengeExpirationDate: String {
        guard let challenge = challenge else { return "" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        
        return "Expiration Date: \(formatter.string(from: challenge.expirationDate))"
    }
    
    var challengeStatus: String {
        guard let challenge = challenge else { return "" }

        return "Status: \(challenge.status.rawValue)"
    }
    
    public func registerDevice() {
        let device = Device(id: factor.identity, sid: factor.sid)
        registerApi.registerDevice(device: device) { result in
            switch result {
                case .success(let status): print("Breadcrumb: Register device successfully  \(status)")
                case .failure(let error): print("Breadcrumb: Unable to register device \(error.localizedDescription)")
            }
        }
    }
    
    public func searchChallenge(completion: @escaping (Challenge?) -> Void) {
        adapter?.searchChallenge(factorSid: factor.sid, completion: { result in
            switch result {
                case .success(let list): completion(list.last)
                case .failure(let error): print("Breadcrumb: \(error.localizedDescription)")
            }
        })
    }
    
    
    public func updateChallenge(approved: Bool, completion: @escaping (Error?) -> Void) {
        guard let challenge = challenge else { return }
        
        adapter?.updateChallenge(factorSid: factor.sid, challengeSid: challenge.sid, status: approved, completion: { result in
            switch result {
                case .success(let status): print("Breadcrumb: Updated challenge successfully \(status)")
                case .failure(let error): print("Breadcrumb: Unable to update challenge \(error.localizedDescription)")
            }
        })
    }
}
