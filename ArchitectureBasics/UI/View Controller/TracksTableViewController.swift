//Some text.

import UIKit

class TracksTableViewController: UITableViewController {
    
    var tracks = [Track]()
    let tracksFetcher = TracksFetcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tracksFetcher.fetchAll { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let tracks):
                self.tracks.append(contentsOf: tracks)
                self.tableView.reloadData()
            }
        }
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
        let track = tracks[indexPath.row]
        cell.configure(with: track)
        return cell
    }
}
