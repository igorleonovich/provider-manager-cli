import Foundation
import SPMUtility
import Basic

struct CommandRegistry {
    
    private let parser: ArgumentParser
    private var commands: [Command] = []
    
    init(usage: String, overview: String) {
        parser = ArgumentParser(usage: usage, overview: overview)
        addOptions()
    }
    
    mutating func register(command: Command.Type) {
        commands.append(command.init(parser: parser))
    }
    
    func run() {
        do {
            let parsedArguments = try parse()
            try process(arguments: parsedArguments)
        }
        catch let error as ArgumentParserError {
            print(error.description)
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func parse() throws -> ArgumentParser.Result {
        let arguments = Array(ProcessInfo.processInfo.arguments.dropFirst())
        return try parser.parse(arguments)
    }
    
    private func process(arguments: ArgumentParser.Result) throws {
        guard let subparser = arguments.subparser(parser),
            let command = commands.first(where: { $0.command == subparser }) else {
            parser.printUsage(on: stdoutStream)
            return
        }
        try command.run(with: arguments)
    }
    
    private func addOptions() {
        let hostArgument = parser.add(option: "--host", shortName: "-h", kind: String.self, usage: "Use custom host name")
        let httpPortArgument = parser.add(option: "--httpport", shortName: "-hp", kind: Int.self, usage: "Use custom HTTP port")
        let wsPortArgument = parser.add(option: "--wsport", shortName: "-wp", kind: Int.self, usage: "Use custom WebSockets port")
        let versionOption = parser.add(option: "--version", kind: Bool.self)
        let verboseOption = parser.add(option: "--verbose", kind: Bool.self, usage: "Show more debugging information")
        
        do {
            let result = try parser.parse(Array(CommandLine.arguments.dropFirst()))
            
            if result.get(versionOption) != nil {
                print("ProviderManager 0.1.0")
                return
            }
            
            if result.get(verboseOption) != nil {
                
            }
            
            if let host = result.get(hostArgument) {
                Constants.host = host
            }
            
            if let httpPort = result.get(httpPortArgument) {
                Constants.httpPort = httpPort
            }
            
            if let wsPort = result.get(wsPortArgument) {
                Constants.wsPort = wsPort
            }
        } catch {
            print(error)
        }
    }
}
