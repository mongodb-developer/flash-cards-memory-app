import Foundation

public protocol UseCase {
    associatedtype inParameterDataType
    associatedtype resultDataType
    
    var businessRules: [BusinessRule]? { get }
    
    func checkBusinessRules() -> Bool
    
    func execute(data: inParameterDataType?, completion: @escaping (_ result: UseCaseResult<resultDataType>) -> Void)
}

public extension UseCase {
    func checkBusinessRules() -> Bool {
        guard let br = businessRules,   // do we have Business Rules attached to this UC?
                  br.map { $0() }.filter({ $0 == false }).isEmpty  // is empty the array of failing checks?
        else { return true }
        
        return false
    }
}
