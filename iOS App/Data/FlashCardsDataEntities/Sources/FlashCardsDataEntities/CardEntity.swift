import Foundation

public protocol CardEntity {
    var title: String { get }
    var backText: String { get }
    var icon: String { get }
    var creationDate: Date { get }
    var lastUpdateDate: Date { get }
}
