import Foundation
import SPMUtility

struct RemoveCommand: Command {
    
    let command = "remove"
    let overview = "Remove deployment config"
    
    private let deploymentID: PositionalArgument<String>
    
    init(parser: ArgumentParser) {
        let subparser = parser.add(subparser: command, overview: overview)
        deploymentID = subparser.add(positional: "deploymentID", kind: String.self, usage: "deploymentID to remove")
    }
    
    func run(with arguments: ArgumentParser.Result) throws {
        guard let deploymentID = arguments.get(deploymentID) else {
            return
        }
        remove(deploymentID)
    }
    
    func remove(_ deploymentID: String) {
        guard let url = URL(string: "\(Constants.baseURL)/deployments/\(deploymentID)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
            } else {
                print("deployment removed")
            }
        }
        task.resume()
    }
}

