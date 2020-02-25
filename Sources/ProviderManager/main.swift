import Foundation
import SPMUtility

var registry = CommandRegistry(commandName: "prom", usage: "<command> <options>", overview: "Provider Manager")
registry.register(command: ClientsCommand.self)
registry.register(command: DeployCommand.self)
registry.register(command: RemoveCommand.self)

do {
    try registry.run()
}
catch let error as ArgumentParserError {
    print(error.description)
}
catch let error {
    print(error.localizedDescription)
}


RunLoop.main.run()
