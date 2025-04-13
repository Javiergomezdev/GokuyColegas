//
//  LoginViewModel.swift
//  GokuYColegas
//
//  Created by Javier Gomez on 11/4/25.
//

import Foundation

class LoginViewModel {
    
    let apiProvider = ApiProvider()

    func validateLogin(email: String, password: String, completion: @escaping (Result<[ApiHero], GAFError>) -> Void) {
        // Lógica de validación de login (puedes agregar una API de login o mock)
        if email == "user@example.com" && password == "password" {
            apiProvider.fetchHeroes { result in
                completion(result)
            }
        } else {
            completion(.failure(.serverError(error: NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Credenciales inválidas"]))))
        }
    }
}
