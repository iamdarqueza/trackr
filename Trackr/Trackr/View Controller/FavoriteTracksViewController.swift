//
//  FavoriteTracksViewController.swift
//  Trackr
//
//  Created by Danmark Arqueza on 1/24/21.
//

import UIKit
import RealmSwift

class FavoriteTracksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var trackList: [Results] = []
    private var track: Results?
    
    var favoriteList = try! Realm().objects(FavoriteTracks.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        configureTableView()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        populateMap()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.showSpecificFavorite.rawValue {
              let destination = segue.destination as! SpecificTrackViewController
              destination.result = track
        }
    }
    
    // MARK: - Configure Table View
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 94
    }
    
    
    // MARK: - Populate table view with Favorite list
    private func populateMap() {
    
      trackList.removeAll()
        
      favoriteList = try! Realm().objects(FavoriteTracks.self)

      for tracks in favoriteList {
        
        let tracks = Results(wrapperType: nil, kind: nil, artistID: nil, collectionID: nil, trackID: nil, artistName: "", collectionName: nil, trackName: tracks.trackName, collectionCensoredName: nil, trackCensoredName: nil, artistViewURL: nil, collectionViewURL: nil, trackViewURL: nil, previewURL: nil, artworkUrl30: nil, artworkUrl60: nil, artworkUrl100: tracks.trackAlbumArt, collectionPrice: nil, trackPrice: tracks.trackPrice, releaseDate: nil, collectionExplicitness: nil, trackExplicitness: nil, discCount: nil, discNumber: nil, trackCount: nil, trackNumber: nil, trackTimeMillis: nil, country: nil, currency: nil, primaryGenreName: tracks.trackGenre, isStreamable: nil, collectionArtistID: nil, collectionArtistViewURL: "", trackRentalPrice: nil, collectionHDPrice: nil, trackHDPrice: nil, trackHDRentalPrice: nil, contentAdvisoryRating: "", longDescription: tracks.trackLongDescription, hasITunesExtras: nil, shortDescription: "", copyright: "", resultDescription: "", amgArtistID: 0, isFavorite: true)
        
        trackList.append(tracks)
      }
        
        self.tableView.reloadData()
    }
    
    
    

}

extension FavoriteTracksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.favoriteTracksTableViewCell.rawValue, for: indexPath) as! FavoriteTracksTableViewCell
        cell.index = indexPath
        
        cell.configure(withTrack: trackList[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.track = trackList[indexPath.row]
        performSegue(withIdentifier: SegueIdentifiers.showSpecificFavorite.rawValue, sender: self)
    }
    
}
