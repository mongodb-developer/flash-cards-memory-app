//
//  Repository.swift
//  
//
//  Created by Diego Freniche Brito on 28/9/21.
//

import Foundation

/// A generic way of encapsulating CRUD operations. These operations can work with a local cache, cache + network or directly with the network
/// That's an implementation detail we're isolated from
public protocol Repository {
    // Generic type for all Repositories
    associatedtype EntityType

    /// Adds one Entity
    /// - parameter ``completion``: closure that returns the added Entity
    func add(_ entity: EntityType, completion: @escaping (RepositoryResponse<Bool>) -> Void)
    
    /// Gets all Entities of this type
    /// - parameter ``completion``: closure to return all Entities
    func getAll(completion: @escaping (RepositoryResponse<[EntityType]>) -> Void)
    
    /// Deletes one entity
    /// - parameter ``completion``: closure to return success or failure
    func delete(_ entity: EntityType, completion: @escaping (RepositoryResponse<Bool>) -> Void)
    
    /// Deletes all entities
    /// - parameter ``completion``: closure to return success or failure
    func deleteAll(completion: @escaping (RepositoryResponse<Bool>) -> Void)

    /// Updates one Entity
    /// - parameter ``completion``: closure that returns the updated Entity
    func update(_ entity: EntityType, completion: @escaping (RepositoryResponse<EntityType>) -> Void)
}
