//Some text.

import UIKit

class TracksTableViewController: UITableViewController {
    
    var tracks = [[String: Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let dataTask = URLSession.shared.dataTask(with: URL(string: "https://itunes.apple.com/search?term=game+of+thrones")!) { (data, response, error) in
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            let tracks = json["results"] as! [[String:Any]]
            self.tracks.append(contentsOf: tracks)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
       dataTask.resume()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath) as! TrackTableViewCell
        let trackInfo = tracks[indexPath.row]
        let trackURLString = trackInfo["artworkUrl100"] as! String
        let trackURL = URL(string: trackURLString)!
        let trackImageData = try! Data(contentsOf: trackURL)
        cell.albumArtImageView.image = UIImage(data: trackImageData)
        cell.trackNameLabel.text = trackInfo["trackName"] as? String
        cell.artistNameLabel.text = trackInfo["artistName"] as? String
        cell.collectionNameLabel.text = trackInfo["collectionName"] as? String
        return cell
    }
}
