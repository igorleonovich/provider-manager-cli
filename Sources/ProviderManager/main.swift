import Foundation

var registry = CommandRegistry(usage: "<command> <options>", overview: "Provider Manager")
registry.register(command: DeployCommand.self)
registry.run()


RunLoop.main.run()
