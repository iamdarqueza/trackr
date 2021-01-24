//
//  AppError.swift
//  Trackr
//
//  Created by Danmark Arqueza on 1/25/21.
//

import Foundation

enum AppError: LocalizedError {

    case responseStatusError(status: String, message: String?)

}

extension AppError {

    var errorDescription: String? {
        switch self {
        case let .responseStatusError(status, message):
            var errorMessage = "Whoops! Something went wrong, please try again."
            if let unwrappedMessage = message {
                errorMessage = unwrappedMessage
            }
            return "\(errorMessage) (Code: \(status))"
        }
    }

}
