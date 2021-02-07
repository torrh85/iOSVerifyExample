//
//  Models.swift
//  iOSVerifyExample
//
//  Created by Hawer Alberto Torres Castañeda on 6/02/21.
//

import Foundation

// Models
public struct AccessToken: Codable {
    var token: String
    var serviceSid: String
    var identity: String
    var factorType: String
}

public struct Identity: Codable {
    var id: String
}

public struct User: Codable {
    var name: String
    var password: String
}

public struct Device: Codable {
    var id: String
    var sid: String
}
