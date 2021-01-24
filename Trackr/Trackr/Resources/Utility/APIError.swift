//
//  APIError.swift
//  Trackr
//
//  Created by Danmark Arqueza on 1/25/21.
//

import Foundation

enum APIError: LocalizedError {
    
  case responseStatusError(status: String, message: String?)
    
}

extension APIError {
    
  var errorDescription: String? {
    switch self {
    case let .responseStatusError(status, message):
      var errorMessage = "Something went wrong, please try again."
      if let unwrappedMessage = message {
        errorMessage = unwrappedMessage
      }
      return "\(errorMessage) (Code: \(status))"
    }
  }
    
}
