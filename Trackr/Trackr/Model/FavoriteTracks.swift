//
//  FavoriteTracks.swift
//  Trackr
//
//  Created by Danmark Arqueza on 1/25/21.
//

import Foundation
import Realm
import RealmSwift

class FavoriteTracks: Object {
    @objc dynamic var trackName = ""
    @objc dynamic var trackGenre = ""
    @objc dynamic var trackPrice = 0.0
    @objc dynamic var trackLongDescription = ""
    @objc dynamic var trackAlbumArt = ""
}
