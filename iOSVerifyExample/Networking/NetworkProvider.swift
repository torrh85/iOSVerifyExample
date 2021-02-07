//
//  NetworkProvider.swift
//  iOSVerifyExample
//
//  Created by Hawer Alberto Torres Castañeda on 6/02/21.
//

import Foundation

struct NetworkProvider: NetworkProvinding {
    func fetch<T>(_ request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        URLSession.shared.dataTask(with: request) { data, response, error in
              do {
                if let error = error {
                  completion(.failure(error))
                  return
                }

                guard let data = data else { return }

                let decodedObject = try JSONDecoder().decode(T.self, from: data)

                completion(.success(decodedObject))
              } catch {
                completion(.failure(error))
              }
            }.resume()
    }
}
