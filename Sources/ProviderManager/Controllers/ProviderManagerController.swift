import Foundation

final class ProviderManagerController {
    
    weak var core: Core?
    
    init(core: Core) {
        self.core = core
    }
    
    func createManager(_ completion: @escaping (Error?) -> Void) {
        
        print("\(Date()) [setup] sending new manager object to server")
        create { createdManager, error in
            if let createdManager = createdManager {
                Environment.managerID = createdManager.id
                completion(nil)
                print("\(Date()) [setup] new manager created")
            } else {
                completion(error)
            }
        }
    }
    
    func create(_ completion: @escaping (ProviderManager?, Error?) -> Void) {
        if let url = URL(string: "\(Constants.baseURL)/managers") {
            do {
                let manager = ProviderManager(type: ProviderManagerType.CLI.rawValue)
                let data = try JSONEncoder().encode(manager)
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.httpBody = data
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")

                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let error = error {
                        print(error)
                    } else if let data = data {
                        do {
                            let createdManager = try JSONDecoder().decode(ProviderManager.self, from: data)
                            completion(createdManager, nil)
                        } catch {
                            completion(nil, error)
                        }
                    }
                }
                task.resume()
            } catch {
                print(error)
            }
        }
    }
}
