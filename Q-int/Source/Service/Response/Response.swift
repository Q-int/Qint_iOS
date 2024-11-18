import Foundation

struct TokenResponse: Codable {
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
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

struct Score: Codable {
    let correctAnswers: Int
    let incorrectAnswers: Int
    
    enum CodingKeys: String, CodingKey {
        case correctAnswers = "correct_answers"
        case incorrectAnswers = "incorrect_answers"
    }
}

struct Incorrect: Codable {
    let answerList: [Answers]
    
    enum CodingKeys: String, CodingKey {
        case answerList = "user_incorrect_answers_element_list"
    }
}

struct Answers: Codable {
    let contents: String
    let commentary: String
    let incorrectAnswer: String
    let correctAnswer: String
    
    enum CodingKeys: String, CodingKey {
        case contents = "contents"
        case commentary = "commentary"
        case incorrectAnswer = "incorrect_answer"
        case correctAnswer = "correct_answer"
    }
}
