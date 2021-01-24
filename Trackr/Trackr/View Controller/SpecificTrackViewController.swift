//
//  SpecificTrackViewController.swift
//  Trackr
//
//  Created by Danmark Arqueza on 1/24/21.
//

import UIKit
import Kingfisher
import RealmSwift

class SpecificTrackViewController: UIViewController {
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var trackGenreLabel: UILabel!
    @IBOutlet weak var trackPriceView: DesignableView!
    @IBOutlet weak var trackPriceLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: DesignableButton!
    @IBOutlet weak var trackLongDescriptionTextView: UITextView!
    
    
    @IBAction func didTapFavoriteButton(_ sender: Any) {
        
        guard let track = result else {
            self.presentDismissableAlertController(title: "Oops!", message: "Invalid track")
            return }
        writeToRealm(track: track)
        self.presentDismissableAlertController(title: "Success", message: "You've added this to your favorites.")
    }
    
    var result: Results?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkFavorite()
    }
    
    
    // MARK: - Configure view
    private func configureView() {
        trackNameLabel.text = "\(result?.trackName ?? result?.collectionName ?? "Unknown")"
        trackGenreLabel.text = "\(result?.primaryGenreName ?? "Unknown")"
        trackPriceLabel.text = "$\(result?.trackPrice ?? result?.collectionPrice ?? 0.0)"
        
        let url = URL(string: "\(result?.artworkUrl100 ?? "")")
        trackImageView.kf.setImage(with: url)
        
        trackLongDescriptionTextView.text = "\(result?.longDescription ?? "No description available..")"
    }
    
    
    // MARK: - Check if favorite track
    private func checkFavorite() {
        if (result?.isFavorite == true) {
            self.favoriteButton.isEnabled = false
            self.favoriteButton.backgroundColor = UIColor.gray
        } else {
            self.favoriteButton.isEnabled = true
            self.favoriteButton.backgroundColor = UIColor.colorWithRGBHex(0x773EE5)
        }
    }
    
    
    // MARK: - Save favorite to Realm database
    private func writeToRealm(track: Results) {
       
        let realm = try! Realm()
           
         try! realm.write {
           let newFavorite = FavoriteTracks()
             
            newFavorite.trackName = "\(track.trackName ?? track.collectionName ?? "Unknown")"
            newFavorite.trackGenre = "\(track.primaryGenreName ?? "Unknown")"
            newFavorite.trackPrice = track.trackPrice ?? track.collectionPrice ?? 0.0
            newFavorite.trackLongDescription = "\(track.longDescription ?? "No description available..")"
            newFavorite.trackAlbumArt = "\(track.artworkUrl100 ?? "")"
             
           realm.add(newFavorite)
         }
        
        
    }

}
