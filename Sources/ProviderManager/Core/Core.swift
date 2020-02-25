import Foundation

final class Core {
    var managerController: ProviderManagerController!
    var websocketController: WebSocketController!
    
    func setup() {
        print("\(Date()) [setup] started")
        managerController = ProviderManagerController(core: self)
    }
}
