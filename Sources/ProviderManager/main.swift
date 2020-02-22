import Foundation

var registry = CommandRegistry(usage: "<command> <options>", overview: "Provider Manager")
registry.register(command: StatusCommand.self)
registry.register(command: DeployCommand.self)
registry.register(command: RemoveCommand.self)
registry.run()

RunLoop.main.run()
