import Foundation
import SPMUtility

struct ClientsCommand: Command {
    
    let command = "clients"
    let overview = "List provider clients"
    var subparser: ArgumentParser
    var options: Options?
    
    init(parser: ArgumentParser) {
        subparser = parser.add(subparser: command, overview: overview)
    }
    
    func run(with arguments: ArgumentParser.Result) throws {
        clients()
    }
    
    private func clients() {
        guard let url = URL(string: "\(Constants.baseURL)/clients") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
            } else if let data = data {
                do {
                    let clients = try JSONDecoder().decode([ProviderClient].self, from: data)
                    clients.forEach { print($0) }
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
}
