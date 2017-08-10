//😘 it is 8/10/17

import Foundation

typealias TracksCompletionHandler = (Result<[Track]>)->()

struct TracksFetcher {
    
     func fetchAll(_ completionHandler: @escaping TracksCompletionHandler) {
        TracksJSONService.fetchAll { (result) in
            switch result {
            case .failure(let error):
                completionHandler(Result.failure(error))
            case .success(let json):
                let tracks = TracksJSONTransformer.tracks(fromJSON: json)
                completionHandler(Result.success(tracks))
            }
        }
    }
}
