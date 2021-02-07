//
//  VerifyRegisterAPI.swift
//  iOSVerifyExample
//
//  Created by Hawer Alberto Torres Castañeda on 6/02/21.
//

import Foundation

struct VerifyRegisterAPI {
    private var network = NetworkProvider()
    
    func registerDevice(device: Device, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let encoded = try? JSONEncoder().encode(device) else { return }
        
        let url = URL(string: "http://localhost:5000/api/devices/register")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        network.fetch(request, completion: completion)
    }
}
