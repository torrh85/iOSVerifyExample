//
//  VerifyTokenAPI.swift
//  iOSVerifyExample
//
//  Created by Hawer Alberto Torres Castañeda on 6/02/21.
//

import Foundation

struct VerifyTokenAPI {
    private var network = NetworkProvider()
    
    func requestAccessToken (_ identity: Identity, completion: @escaping (Result<AccessToken, Error>) -> Void) {
        let url = URL(string: "http://localhost:5000/api/devices/token")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.encodeParameters(parameters: ["id" : identity.id])
        
        network.fetch(request, completion: completion)
    }
}
