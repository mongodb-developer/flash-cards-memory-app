import Foundation

public enum NetworkErrors: Int {
    case malformedURL = 1
    
    case ok = 200
    case error = -1
}

public struct NetworkRespose<T> {
    public let code: NetworkErrors
    public let message: String
    public let data: T
}
