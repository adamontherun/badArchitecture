//😘 it is 8/10/17

import Foundation

/// The result of a an asynchronous method
enum Result<T> {
    case success(T)
    case failure(Error)
}
