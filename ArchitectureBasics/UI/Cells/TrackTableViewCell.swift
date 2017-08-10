//Some text.

import UIKit

class TrackTableViewCell: UITableViewCell {

    @IBOutlet weak var albumArtImageView: UIImageView!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    
    func configure(with track: Track) {
        collectionNameLabel.text = track.collectionName
        artistNameLabel.text = track.artistName
        trackNameLabel.text = track.name
        // albumArtImageView.image = TODO:
    }
}
