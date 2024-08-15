import Foundation


struct AuthResponse: Codable {
    let tokenResponse: TokenResponse
    let message: String
}

struct TokenResponse: Codable {
    let accessToken, refreshToken: String
}
