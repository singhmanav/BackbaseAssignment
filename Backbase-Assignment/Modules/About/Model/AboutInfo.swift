import Foundation

// MARK: - AboutInfoData protocol

public protocol AboutInfoData {
    var companyName: String { get }
    var companyAddress: String  { get }
    var postalCode: String { get }
    var city: String { get set }
    var details: String { get }
    var latitude:String { get set }
    var longitude:String { get set }
    var country:String { get set }
}

// MARK: - AboutInfo object

public struct AboutInfo: Codable, AboutInfoData {
    public let companyName: String
    public let companyAddress: String
    public let postalCode: String
    public var city: String
    public let details: String
    public var latitude:String
    public var longitude:String
    public var country:String
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.companyName = try container.decodeIfPresent(String.self, forKey: .companyName) ?? ""
        self.companyAddress = try container.decodeIfPresent(String.self, forKey: .companyAddress) ?? ""
        self.postalCode = try container.decodeIfPresent(String.self, forKey: .postalCode) ?? ""
        self.city = try container.decodeIfPresent(String.self, forKey: .city) ?? ""
        self.country = try container.decodeIfPresent(String.self, forKey: .country) ?? ""
        self.details = try container.decodeIfPresent(String.self, forKey: .details) ?? ""
        self.latitude = try container.decodeIfPresent(String.self, forKey: .latitude) ?? ""
        self.longitude = try container.decodeIfPresent(String.self, forKey: .longitude) ?? ""
    }
}
