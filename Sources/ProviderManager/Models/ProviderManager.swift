import Foundation

public final class ProviderManager: Codable {
    
    public var id: String?
    public var type: String
    
    public init(type: String) {
        self.type = type
    }
}

enum ProviderManagerType: String {
    case CLI
    case Web
}
