//
//  TrackRouter.swift
//  Trackr
//
//  Created by Danmark Arqueza on 1/25/21.
//

import Alamofire
import Foundation
import KeychainSwift

enum TrackRouter: URLRequestConvertible {
    
    

    case getTrackList(term: String, country: String, media: String, all: String)

    
    private var baseURLString: String {
        return Server.baseURL.rawValue
    }

    private var method: HTTPMethod {
        switch self {
        case .getTrackList:
            return .get
     

        }
    }

    private var path: String {
        switch self {
        case .getTrackList:
            return "/search"
      
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try baseURLString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Authorization...
        if let base64Credentials = KeychainSwift().get(UserDefaults.Keys.base64Credentials.rawValue) {
            urlRequest.setValue("Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")
        }

        switch self {
        case .getTrackList(let term, let country, let media, let all):
            let parameters: [String: Any] = [
              "term": term,
              "amp;country": country,
              "amp;media": media,
              "amp;all": all,
            ]
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }

}
