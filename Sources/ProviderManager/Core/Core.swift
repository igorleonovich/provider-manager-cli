import Foundation

final class Core {
    
    var managerController: ProviderManagerController!
    var webSocketController: WebSocketController!
    
    func setup() {
        print("\(Date()) [setup] started")
        managerController = ProviderManagerController(core: self)
    }
    
    func connect(_ completion: @escaping (Error?) -> Void) {
        if let managerID = Environment.managerID {
            print("\(Date()) [setup] managerID detected \(managerID)")
            webSocketController = WebSocketController(core: self, managerID: managerID)
            webSocketController!.start { error in
                if error == nil {
                    completion(nil)
                } else if error == WebSocketController.Error.managerIDNotFoundOnServer {
                    print("\(Date()) [setup] clearing managerID")
                    Environment.managerID = nil
                    self.connect(completion)
                }
            }
        } else {
            print("\(Date()) [setup] managerID not detected]")
            managerController.createManager { error in
                if error == nil {
                    print("\(Date()) [setup] try to connect ws again")
                    self.connect(completion)
                } else {
                    completion(error)
                }
            }
        }
    }
}
