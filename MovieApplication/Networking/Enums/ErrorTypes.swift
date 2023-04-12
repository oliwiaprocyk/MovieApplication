//
//  ErrorTypes.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 17/03/2023.
//

import Foundation

enum ErrorTypes: String, Error {
    case invalidData    = "invalid data"
    case invalidUrl     = "invalid url"
    case generalError   = "an error happened"
}
