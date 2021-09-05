import Foundation

public struct RepositoryResponse<T> {
    public let code: Int
    public let message: String
    public let data: T
    
    public init(code: Int, message: String, data: T) {
        self.code = code
        self.message = message
        self.data = data
    }
}
