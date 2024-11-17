import Foundation

struct TokenResponse: Codable {
    let access_token: String
    let refresh_token: String
    
    enum CodingKeys: String, CodingKey {
        case access_token = "access_token"
        case refresh_token = "refresh_token"
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
    let correct_answers: Int
    let incorrect_answers: Int
    
    enum CodingKeys: String, CodingKey {
        case correct_answers = "correct_answers"
        case incorrect_answers = "incorrect_answers"
    }
}

struct Incorrect: Codable {
    let user_incorrect_answers_element_list: [Answers]
}

struct Answers: Codable {
    let contents: String
    let commentary: String
    let incorrect_answer: String
    let correct_answer: String
    
    enum CodingKeys: String, CodingKey {
        case contents = "contents"
        case commentary = "commentary"
        case incorrect_answer = "incorrect_answer"
        case correct_answer = "correct_answer"
    }
}
