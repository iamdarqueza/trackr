//
//  TrackServices.swift
//  Trackr
//
//  Created by Danmark Arqueza on 1/25/21.
//

import Foundation
import Alamofire
import CodableAlamofire

class TrackServices: BaseServices {

    // MARK: - Stored

    static let shared = TrackServices()


    // MARK: - Initialization

    private init() {

    }


    // MARK: - Instance

    func getTrackList(term: String, country: String, media: String, all: String, completion: @escaping (Tracks?, Error?) -> Void) {
    genericNetworkRequest(urlRequest: TrackRouter.getTrackList(term: term, country: country, media: media, all: all), completion: completion)
  }


  
}


