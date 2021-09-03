public struct UseCaseResult<T> {
    public let value: T
    public let code: ResultExitCode
    
    public init(value: T, code: ResultExitCode) {
        self.value = value
        self.code = code
    }
}

/// Exit Code
public enum ResultExitCode {
    case Success
    case GeneralError
    case Unknown
}
