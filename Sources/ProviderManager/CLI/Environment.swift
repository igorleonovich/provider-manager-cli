import Foundation

struct Environment {
    
    private static let homePath = ProcessInfo.processInfo.environment["HOME"]
    private static let filePath = "\(homePath!)/.provider_manager_id"
    
    static var managerID: String? {
        get {
            let providerManagerID = CLI.runCommand(args: "cat", filePath).output.first!
            return providerManagerID.isEmpty ? nil : providerManagerID
        }
        set {
            if let newValue = newValue {
                do {
                    try newValue.write(toFile: filePath, atomically: true, encoding: .utf8)
                } catch {
                    print(error)
                }
            } else {
                CLI.runCommand(args: "rm", filePath)
            }
        }
    }
}
