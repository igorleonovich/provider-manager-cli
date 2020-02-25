import Foundation

public final class ProviderManager: Codable {
    
    public var id: UUID?
    
    init(id: UUID?) {
        self.id = id
    }
}
