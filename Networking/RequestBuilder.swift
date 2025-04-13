//
//  RequestBuilder.swift
//  GokuYColegas
//
//  Created by Javier Gomez on 9/4/25.
//

import Foundation

// Struct que se encarga de construir las URLs y los requests
struct RequestBuilder {
    let host = "dragonball.keepcoding.education" // Host base de la API

    // Token JWT para autenticación en la API
    let token = "eyJraWQiOiJwcml2YXRlIiwidHlwIjoiSldUIiwiYWxnIjoiSFMyNTYifQ.eyJlbWFpbCI6ImphdmllcmdvbWV6ZGV2QGdtYWlsLmNvbSIsImlkZW50aWZ5IjoiMTU3QjczMUUtNkMyRC00MERGLThGRTktNzE1RTEwN0FBOTM5IiwiZXhwaXJhdGlvbiI6NjQwOTIyMTEyMDB9.Ml5fTPysuEMm08E-UWOfQGL_K9wOnR2y4tu56KfPYqs"

    // Construye la URL completa con host y path
    func url(endPoint: GAFEnpoints) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = self.host
        components.path = endPoint.path()
        return components.url
    }

    // Construye un URLRequest totalmente configurado
    func build(enpoint: GAFEnpoints) throws -> URLRequest {
        guard let url = url(endPoint: enpoint) else {
            throw GAFError.badURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = enpoint.httpMethod()
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = enpoint.params()

        return request
    }
}
