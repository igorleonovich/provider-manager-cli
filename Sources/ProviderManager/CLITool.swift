import Foundation

enum Command: String {
    case status
    case deploy
    case remove
}

public final class CLITool {
    
    private let arguments: [String]

    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }

    public func run() throws {
        if let firstArgument = arguments[safe: 1], let command = Command.init(rawValue: firstArgument) {
            switch command {
            case .deploy:
                guard let secondArgument = arguments[safe: 2] else { return }
                print("\n[deploy]\n")
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: secondArgument))
                    let _ = try JSONDecoder().decode(DeploymentConfig.self, from: data)
                    deploy(data)
                } catch {
                    print(error)
                    throw Error.cantReadConfigFromJSONFile
                }
            case .remove:
                guard let secondArgument = arguments[safe: 2] else { return }
                print("\n[remove]\n")
                remove(secondArgument)
            case .status:
                print("\n[status]\n")
                status()
            }
        } else {
            print("\n[status]\n")
        }
    }

    func deploy(_ data: Data) {
        
        guard let url = URL(string: "http://localhost:8888/deployments") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
            } else {
                print("[server] deployment started]")
            }
        }
        task.resume()
    }

    func remove(_ deploymentID: String) {
        guard let url = URL(string: "http://localhost:8888/deployments/\(deploymentID)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
            } else {
                print("deployment deleted")
            }
        }
        task.resume()
    }
    
    func status() {
        guard let url = URL(string: "http://localhost:8888/deployments") else { return }
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

public extension CLITool {
    enum Error: Swift.Error {
        case cantReadConfigFromJSONFile
    }
}

enum DeploymentState: String {
    case transporting
    case deploying
    case running
    case stopped
}

struct Deployment: Decodable {
    var id: UUID
    var state: String
}
