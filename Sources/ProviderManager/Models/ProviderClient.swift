import Foundation

public final class ProviderClient: Codable {
    
    public var id: UUID?
    public var hostName: String
    public var userName: String
    public var osType: String
    public var osVersion: String
    public var kernelType: String
    public var kernelVersion: String
    public var state: String
    public var cpuUsage: Double?
    public var freeRAM: Int?
    
    init(id: UUID?, hostName: String, userName: String, osType: String, osVersion: String, kernelType: String, kernelVersion: String, state: String, cpuUsage: Double?, freeRAM: Int?) {
        self.id = id
        self.hostName = hostName
        self.userName = userName
        self.osType = osType
        self.osVersion = osVersion
        self.kernelType = kernelType
        self.kernelVersion = kernelVersion
        self.state = state
        self.cpuUsage = cpuUsage
        self.freeRAM = freeRAM
    }
}
