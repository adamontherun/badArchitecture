//😘 it is 8/10/17

import Foundation

typealias TracksJSONCompletionHandler = (Result<[Any]>)->()

enum TracksJSONService {
    
    static func fetchAll(_ completionHandler: @escaping TracksJSONCompletionHandler) {
        guard  let gameOfThronesURL = URL(string: "https://itunes.apple.com/search?term=game+of+thrones") else {
            completionHandler(Result.failure(TrackError.badURL))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: gameOfThronesURL) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let _ = error {
                    // map this nsurlsession error to my custom error
                    completionHandler(Result.failure(TrackError.errorFromAPI))
                    return
                }
                guard let data = data else {
                    completionHandler(Result.failure(TrackError.errorFromAPI))
                    return
                }
                transform(data: data, completionHandler)
            }
        }
        dataTask.resume()
    }
    
    private static func transform(data: Data, _ completionHandler: TracksJSONCompletionHandler) {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: Any] else {
            completionHandler(Result.failure(TrackError.badData))
            return
        }
        guard let tracks = json["results"] as? [[String:Any]] else {
            completionHandler(Result.failure(TrackError.badData))
            return
        }
        completionHandler(Result.success(tracks))
    }
}
