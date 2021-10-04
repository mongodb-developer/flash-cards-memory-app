import Foundation


/// UseCase: generic definition of what a UseCase is: some code than runs in an ``execute(data:completion:)`` method and returns a value
/// A Use Case needs some input data of type ``inParameterDataType`` and return data of type ``resultDataType``
/// To return data, instead of simply returning ``resultDataType`` we use a ``UseCaseResult`` so we can return status codes, etc.
public protocol UseCase {
    associatedtype inParameterDataType
    associatedtype resultDataType
    
    /// Business rules to be checked before executing this Use Case
    var businessRules: [BusinessRule]? { get }
    
    /// Checking of the business rules happens here
    /// - Returns: true if all ``BusinessRule`` passed
    func checkBusinessRules() -> Bool
    
    func execute(data: inParameterDataType?, completion: @escaping (_ result: UseCaseResult<resultDataType>) -> Void)
}

public extension UseCase {
    /// Naive implementation of checking some business rules, just checking each one and if one fails, the whole check fails
    func checkBusinessRules() -> Bool {
        guard let br = businessRules,   // do we have Business Rules attached to this UC?
                  br.map { $0() }.filter({ $0 == false }).isEmpty  // is empty the array of failing checks?
        else { return true }
        
        return false
    }
}
