//😘 it is 8/10/17

import Foundation

enum TracksJSONTransformer {
    
    static func tracks(fromJSON json: [Any])->[Track] {
        return json.flatMap { track(fromJSON: $0 as? [String: Any]) }
    }
    
    static private func track(fromJSON json: [String:Any]?)->Track? {
        guard
            let json = json,
            let name = json["trackName"] as? String,
            let artistName = json["artistName"] as? String,
            let collectionName = json["collectionName"] as? String,
            let trackCoverArtString = json["artworkUrl100"] as? String,
            let trackCoverArtURL = URL(string: trackCoverArtString) else { return nil}
        
        return Track(name: name, artistName: artistName, collectionName: collectionName, coverArtImage: trackCoverArtURL)
    }
}
