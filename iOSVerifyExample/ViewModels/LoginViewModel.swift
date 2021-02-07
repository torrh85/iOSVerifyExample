//
//  LoginViewModel.swift
//  iOSVerifyExample
//
//  Created by Hawer Alberto Torres Castañeda on 6/02/21.
//

import Foundation

public struct LoginViewModel {
    private var loginApi = VerifyLoginAPI()
    
    public func login(_ user: User, completion: @escaping (Result<Identity, Error>) -> Void) {
        loginApi.requestLogin(user) { result in
            completion(result)
        }
    }
}
