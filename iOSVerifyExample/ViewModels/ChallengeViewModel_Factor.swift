//
//  ChallengeViewModel_Factor.swift
//  iOSVerifyExample
//
//  Created by Hawer Alberto Torres Castañeda on 6/02/21.
//

import Foundation

extension ChallengeViewModel {
    public var dataSid: String {
        return "Name: \(factor.friendlyName)"
    }
    
    public var date: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        return "Creation date: \(formatter.string(from: factor.createdAt))"
    }
    
    public var sid: String {
        return "Sid: \(factor.sid)"
    }
    
    public var factorType: String {
        return "Type: \(factor.type)"
    }
    
    public var factorStatus: String {
        return "Status: \(factor.status.rawValue)"
    }
}
