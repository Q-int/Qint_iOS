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

struct Option: Codable {
    let answerID: Int
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case answerID = "answer_id"
        case text
    }
}

struct Question: Codable {
    let questionID: Int
    let contents: String
    let options: [Option]
    
    enum CodingKeys: String, CodingKey {
        case questionID = "question_id"
        case contents
        case options
    }
}

