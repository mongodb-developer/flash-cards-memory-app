//
//  File.swift
//  
//
//  Created by Diego Freniche Brito on 29/9/21.
//

import Foundation
import RealmSwift

/// Initializes Realm
public struct FlashCardsRealm {
    public static var realm: Realm?

    
    /// Inits a local Realm to save, read, etc. Decks and Cards
    /// - Returns: An initialized local Realm or nil if something bad happens
    public static func initLocalRealm() -> Realm? {
        
        do {
            let fileUrl = Realm.Configuration().fileURL?.deletingLastPathComponent()
                    .appendingPathComponent("FlashCards.realm")
            
            // Realm Configuration for this local Realm
            let configuration = Realm.Configuration(fileURL: fileUrl,
                                                    syncConfiguration: nil,
                                                    encryptionKey: nil,
                                                    readOnly: false,
                                                    schemaVersion: 1,
                                                    migrationBlock: nil,
                                                    deleteRealmIfMigrationNeeded: true,
                                                    shouldCompactOnLaunch: nil,
                                                    objectTypes: nil)
            let realm = try Realm(configuration: configuration, queue: .main)
            FlashCardsRealm.realm = realm
            return realm
        } catch {
            print("Something bad happened: \(error)")
            return nil
        }
    }
    
    public static func initMongoDBRealm(completion: @escaping () -> Void) -> Void {
       
        let app = App(id: "flashcards-spblk")
        
        // Log in anonymously.
        app.login(credentials: Credentials.anonymous) { (result) in
            // Remember to dispatch back to the main thread in completion handlers
            // if you want to do anything on the UI.
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print("Login failed: \(error)")
                    completion()

                case .success(let user):
                    print("Login as \(user) succeeded!")
                    // The partition determines which subset of data to access.
                    let partitionValue = "partitionKey"
                    // Get a sync configuration from the user object.
                    let configuration = user.configuration(partitionValue: partitionValue)
                    // Open the realm asynchronously to ensure backend data is downloaded first.
                    Realm.asyncOpen(configuration: configuration) { (result) in
                        switch result {
                        case .failure(let error):
                            print("Failed to open realm: \(error.localizedDescription)")
                            // Handle error...
                            completion()
                        case .success(let mongoDBRealm):
                            // Realm opened
                            FlashCardsRealm.realm = mongoDBRealm
                            completion()
                        }
                    }
                }
            }
        }
    }
}
