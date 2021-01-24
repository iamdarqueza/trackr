//
//  TrackListTableViewCell.swift
//  Trackr
//
//  Created by Danmark Arqueza on 1/24/21.
//

import UIKit
import Kingfisher
import SkeletonView

class TrackListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var trackGenreLabel: UILabel!
    
    @IBOutlet weak var trackPriceView: UIView!
    @IBOutlet weak var trackPriceLabel: UILabel!
    
    var index: IndexPath?

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        trackImageView.layer.cornerRadius = 5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(withTrack track: Results) {
        trackNameLabel.text = "\(track.trackName ?? track.collectionName ?? "Unknown")"
        trackGenreLabel.text = "\(track.primaryGenreName ?? "Unknown")"
        trackPriceLabel.text = "$\(track.trackPrice ?? track.collectionPrice ?? 0.0)"
        
        let url = URL(string: "\(track.artworkUrl100 ?? "")")
        trackImageView.kf.setImage(with: url)
      

    }
    
    
    func showSkeletonView() {
        trackNameLabel.showAnimatedGradientSkeleton()
        trackGenreLabel.showAnimatedGradientSkeleton()
        trackPriceLabel.showAnimatedGradientSkeleton()
        trackImageView.showAnimatedGradientSkeleton()
        trackPriceView.showAnimatedGradientSkeleton()
    }
    
    func hideSkeletonView() {
        trackNameLabel.hideSkeleton()
        trackGenreLabel.hideSkeleton()
        trackPriceLabel.hideSkeleton()
        trackImageView.hideSkeleton()
        trackPriceView.hideSkeleton()
    }

}
