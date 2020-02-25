import Foundation

final class ProviderManagerController {
    
    weak var core: Core?
    
    init(core: Core) {
        self.core = core
    }
}
