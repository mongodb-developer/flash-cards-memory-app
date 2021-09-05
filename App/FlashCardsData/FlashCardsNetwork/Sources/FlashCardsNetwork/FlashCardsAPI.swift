import Foundation

public struct FlashCardsAPI {
    private static let baseURL = "https://realmflashcards.netlify.app/api/"
    
    public struct DeckAPI {
        
        public struct DeckAPIResponse: Decodable {
            let decks: [DeckNetworkEntity]
        }
        
        public init() {}
    
        public func getAllDecks(_ decksPath: String = "/decks.json",
                                completion: @escaping (NetworkRespose<[DeckNetworkEntity]>) -> Void) {
            let decksURL = "\(baseURL)\(decksPath)"
            guard let url = URL(string: decksURL) else {
                completion(NetworkRespose(code: .malformedURL, message: "Error un URL \(decksURL)", data: []))
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let jsonDecoder = JSONDecoder()

                    do {
                        let parsedJSON = try jsonDecoder.decode(DeckAPIResponse.self, from: data)
                        completion(NetworkRespose(code: .ok, message: "All OK", data: parsedJSON.decks))
                    } catch {
                        completion(NetworkRespose(code: .error, message: error.localizedDescription, data: []))
                    }
                }
           }.resume()
        }
    }
}
