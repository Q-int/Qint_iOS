import Foundation

struct Response: Codable {
    let tokenResponse: TokenResponse
}

struct TokenResponse: Codable {
    let accessToken, refreshToken: String
}
