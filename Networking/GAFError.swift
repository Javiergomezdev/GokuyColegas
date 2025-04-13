//
//  GAFError.swift
//  GokuYColegas
//
//  Created by Javier Gomez on 9/4/25.
//
import Foundation
// Enum con errores personalizados para manejar respuestas de red
enum GAFError: Error {
    case badURL                          // URL inválida
    case serverError(error: Error)      // Error lanzado por el servidor
    case responseError(code: Int?)      // Código HTTP incorrecto
    case noDataReceived                 // No se recibió información
    case errorParsingData               // Fallo al decodificar datos
}
