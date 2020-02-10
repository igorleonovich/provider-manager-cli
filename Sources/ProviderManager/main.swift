import Foundation

let cliTool = CLITool()
do {
    try cliTool.run()
} catch {
    print(error)
}

RunLoop.main.run()
