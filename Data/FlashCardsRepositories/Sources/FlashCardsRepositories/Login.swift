import FlashCardsDataModels

public protocol LoginRepository {
    func login(completion: (UserCredentialsEntity) -> Void)
    func logout()
    func register(user: UserCredentialsEntity)
}
