//
//  FavoriteTracksTableViewCell.swift
//  Trackr
//
//  Created by Danmark Arqueza on 1/25/21.
//

import UIKit
import Kingfisher

class FavoriteTracksTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var trackGenreLabel: UILabel!
    @IBOutlet weak var trackPriceLabel: UILabel!
    
    
    
    var index: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func configure(withTrack track: Results) {
        trackNameLabel.text = "\(track.trackName ?? track.collectionName ?? "Unknown")"
        trackGenreLabel.text = "\(track.primaryGenreName ?? "Unknown")"
        trackPriceLabel.text = "$\(track.trackPrice ?? track.collectionPrice ?? 0.0)"
        
        let url = URL(string: "\(track.artworkUrl100 ?? "")")
        trackImageView.kf.setImage(with: url)
      

    }
    
    
}
