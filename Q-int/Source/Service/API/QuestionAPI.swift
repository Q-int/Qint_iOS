import UIKit
import Moya

enum QuestionAPI {
    case getQuestions(categories: [String], token: String)
    case judge(question_id: Int, answer_id: Int, token: String)
}

extension QuestionAPI: TargetType {
    var baseURL: URL { return URL(string: "http://192.168.143.87:8080/questions")! }
    
    var path: String {
        switch self {
        case .getQuestions:
            return "/categories"
        case .judge:
            return "/judge"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getQuestions:
            return .get
        default:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .getQuestions(categories, _):
            return .requestParameters(
                parameters: [
                    "categories": categories.joined(separator: ",")
                ],
                encoding: URLEncoding.queryString
            )
        case let .judge(question_id, answer_id, _):
            return .requestParameters(
                parameters: [
                    "question_id": question_id,
                    "answer_id": answer_id
                ], encoding: JSONEncoding.default
            )
        }
    }

    
    var headers: [String : String]? {
        switch self {
        case .getQuestions(_, token: let token), .judge(_, _, token: let token):
            return ["Authorization": "Bearer " + token]
        }
    }
}
