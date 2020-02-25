import Foundation
import WebSocket

final class WebSocketController {
    
    weak var core: Core?
    var managerID: String
    var webSocket: WebSocket!
    
    init(core: Core, managerID: String) {
        self.core = core
        self.managerID = managerID
    }
}
