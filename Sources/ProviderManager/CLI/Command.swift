import Foundation
import SPMUtility

protocol Command {
    var command: String { get }
    var overview: String { get }
    var subparser: ArgumentParser { get }
    var options: Options? { get set }
    
    init(parser: ArgumentParser)
    func run(with arguments: ArgumentParser.Result) throws
}

extension Command {
    
    func getOptions() -> Options {
        let hostArgument = subparser.add(option: "--host", shortName: "-h", kind: String.self, usage: "Use custom host name")
        let httpPortArgument = subparser.add(option: "--httpport", shortName: "-hp", kind: Int.self, usage: "Use custom HTTP port")
        let wsPortArgument = subparser.add(option: "--wsport", shortName: "-wp", kind: Int.self, usage: "Use custom WebSockets port")
        let versionOption = subparser.add(option: "--version", kind: Bool.self)
        let verboseOption = subparser.add(option: "--verbose", kind: Bool.self, usage: "Show more debugging information")
        return Options(hostArgument: hostArgument, httpPortArgument: httpPortArgument, wsPortArgument: wsPortArgument, versionOption: versionOption, verboseOption: verboseOption)
    }
    
    func processOptions(with arguments: ArgumentParser.Result) {
        guard let options = options else { return }
        if arguments.get(options.versionOption) != nil {
            print("ProviderManager 0.1.0")
            return
        }

        if arguments.get(options.verboseOption) != nil {

        }

        if let host = arguments.get(options.hostArgument) {
            Constants.host = host
        }

        if let httpPort = arguments.get(options.httpPortArgument) {
            Constants.httpPort = httpPort
        }

        if let wsPort = arguments.get(options.wsPortArgument) {
            Constants.wsPort = wsPort
        }
    }
}

struct Options {
    var hostArgument: OptionArgument<String>
    var httpPortArgument: OptionArgument<Int>
    var wsPortArgument: OptionArgument<Int>
    var versionOption: OptionArgument<Bool>
    var verboseOption: OptionArgument<Bool>
}
