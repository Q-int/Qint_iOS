import Foundation

struct TokenResponse: Decodable {
    let access: String
}

struct AuthCodeCheck: Codable {
    let isVerified: Bool
}

struct EmailVerify: Codable {
    let success: Bool
}

struct QuestionsResponse: Codable {
    let questions: [Question]
}

struct Question: Codable {
    let question_id: Int
    let contents: String
    let options: [Option]
}

struct Option: Codable {
    let answer_id: Int
    let text: String
}
