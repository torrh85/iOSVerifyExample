//
//  TwilioAdapter.swift
//  iOSVerifyExample
//
//  Created by Hawer Alberto Torres Castañeda on 6/02/21.
//

import TwilioVerify

public final class TwilioVerifyAdapter {
    public typealias Completion<T> = (Result<T, Error>) -> Void
    
    private var twilioVerify: TwilioVerify?
    
    init?() throws {
        twilioVerify = try TwilioVerifyBuilder().build()
    }
    
    public func createFactor(name: String, accessToken: AccessToken, completion: @escaping Completion<String>) {
        let payload = PushFactorPayload(friendlyName: name, serviceSid: accessToken.serviceSid, identity: accessToken.identity, pushToken: "00000000000000000000000000000000000000000000000000000000", accessToken: accessToken.token)
        
        self.twilioVerify?.createFactor(withPayload: payload, success: { factor in
            completion(.success(factor.sid))
        }, failure: { error  in
            completion(.failure(error))
        })
    }
    
    public func verifyFactor(factorSid: String, completion: @escaping Completion<Factor>) {
        let payload = VerifyPushFactorPayload(sid: factorSid)
        twilioVerify?.verifyFactor(withPayload: payload, success: {  factor in
            completion(.success(factor))
        }, failure: { error in
            completion(.failure(error))
        })
    }
    
    public func searchChallenge(factorSid: String, completion: @escaping  Completion<[Challenge]>) {
        let challengeListPayload = ChallengeListPayload(factorSid: factorSid, pageSize: 10)
        twilioVerify?.getAllChallenges(withPayload: challengeListPayload, success: { challengeList in
            completion(.success(challengeList.challenges))
        }, failure: { error in
            completion(.failure(error))
        })
    }
    
    public func updateChallenge(factorSid: String, challengeSid: String, status: Bool, completion: @escaping Completion<Bool>) {
        let challengeStatus: ChallengeStatus = status ? .approved : .denied
        let challengePayload = UpdatePushChallengePayload(factorSid: factorSid, challengeSid: challengeSid, status: challengeStatus)
        twilioVerify?.updateChallenge(withPayload: challengePayload, success: {
            completion(.success(true))
        }, failure: { error in
            completion(.failure(error))
        })
    }
}


