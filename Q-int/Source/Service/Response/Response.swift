import Foundation

struct TokenResponse: Decodable {
    let access: String
}

struct AuthCodeCheck: Codable {
    let isVerified: Bool
    
    enum CodingKeys: String, CodingKey {
        case isVerified = "is_verified"
    }
}

struct EmailVerify: Codable {
    let success: Bool
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
    }
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

struct Answer: Codable {
    let answerText: String
    let commentary: String
    let isCorrect: Bool
    
    enum CodingKeys: String, CodingKey {
        case answerText = "answer_text"
        case commentary
        case isCorrect = "is_correct"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        answerText = try container.decode(String.self, forKey: .answerText)
        commentary = try container.decode(String.self, forKey: .commentary)
        isCorrect = try container.decode(Bool.self, forKey: .isCorrect)
    }
}
