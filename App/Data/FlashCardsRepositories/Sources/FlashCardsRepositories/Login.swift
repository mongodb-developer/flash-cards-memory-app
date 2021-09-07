public protocol LoginRepository {
    associatedtype UserCredentialsEntity
    
    func login(completion: (UserCredentialsEntity) -> Void)
    func logout()
    func register(user: UserCredentialsEntity)
}
