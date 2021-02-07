//
//  VerifyLoginAPI.swift
//  iOSVerifyExample
//
//  Created by Hawer Alberto Torres Castañeda on 6/02/21.
//

import Foundation

struct VerifyLoginAPI {
    private var network = NetworkProvider()
    
    func requestLogin(_ user: User, completion: @escaping (Result<Identity, Error>) -> Void) {
        guard let encoded = try? JSONEncoder().encode(user) else { return }
        
        let url = URL(string: "http://localhost:5000/api/login")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        network.fetch(request, completion: completion)
    }
}
