import Foundation

struct Response: Codable {
    let tokenResponse: TokenResponse
}

struct TokenResponse: Codable {
    let accessToken, refreshToken: String
}

struct EmailResponse: Codable {
    let isVerified: Bool
    
    enum CodingKeys: String, CodingKey {
        case isVerified = "isVerified" 
    }
}

