import Foundation

struct Deployment: Decodable {
    var id: UUID
    var state: String
}

enum DeploymentState: String {
    case transporting
    case deploying
    case running
    case stopped
}
