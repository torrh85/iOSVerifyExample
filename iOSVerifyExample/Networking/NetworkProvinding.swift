//
//  NetworkProvinding.swift
//  iOSVerifyExample
//
//  Created by Hawer Alberto Torres Castañeda on 6/02/21.
//

import Foundation

protocol NetworkProvinding {
    func fetch<T: Decodable>(_ request: URLRequest, completion: @escaping (Result<T, Error>) -> Void)
}
