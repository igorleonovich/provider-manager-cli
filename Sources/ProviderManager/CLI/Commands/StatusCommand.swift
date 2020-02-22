import Foundation
import SPMUtility

struct StatusCommand: Command {
    
    let command = "status"
    let overview = "Deployment configs status"
    
    init(parser: ArgumentParser) {
        let subparser = parser.add(subparser: command, overview: overview)
    }
    
    func run(with arguments: ArgumentParser.Result) throws {
        status()
    }
    
    private func status() {
        guard let url = URL(string: "\(Constants.baseURL)/deployments") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
            } else if let data = data {
                do {
                    let deployments = try JSONDecoder().decode([Deployment].self, from: data)
                    print(deployments)
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
}
