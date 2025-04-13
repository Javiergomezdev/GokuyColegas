//
//  LoginUSeCase.swift
//  GokuYColegas
//
//  Created by Javier Gomez on 11/4/25.
//

import Foundation

class LoginUseCase {
    
    private let apiProvider: ApiProvider
    
    init(apiProvider: ApiProvider = ApiProvider()) {
        self.apiProvider = apiProvider
    }

    func login(email: String, password: String, completion: @escaping (Result<[ApiHero], GAFError>) -> Void) {
        // Validación de login
        if email == "user@example.com" && password == "password" {
            apiProvider.fetchHeroes { result in
                completion(result)
            }
        } else {
            completion(.failure(.serverError(error: NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Credenciales inválidas"]))))
        }
    }
}
