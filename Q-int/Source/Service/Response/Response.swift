import Foundation

struct Response: Codable {
    let tokenResponse: TokenResponse
}

struct TokenResponse: Codable {
    let accessToken, refreshToken: String
}

struct AuthCodeCheck: Codable {
    let isVerified: Bool
}

struct EmailVerify: Codable {
    let success: Bool
}

