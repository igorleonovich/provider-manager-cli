import Foundation

var registry = CommandRegistry(commandName: "prom", usage: "<command> <options>", overview: "Provider Manager")
registry.register(command: ClientsCommand.self)
registry.register(command: DeployCommand.self)
registry.register(command: RemoveCommand.self)
registry.run()

RunLoop.main.run()
