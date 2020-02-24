import Foundation

struct ProviderClient: Codable {
    
    public var id: String
    public var hostName: String
    public var userName: String
    public var osType: String
    public var osVersion: String
    public var kernelType: String
    public var kernelVersion: String
    public var state: String
    public var cpuUsage: Double?
    public var freeRAM: Int?
}
