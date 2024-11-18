import UIKit
import Moya

enum QuestionAPI {
    case getQuestions(categories: [String], token: String)
    case judge(question_id: Int, answer_id: Int, token: String)
    case next(move_to_next_problem: Bool, token: String)
    case home(move_to_home: Bool, token: String)
}

extension QuestionAPI: TargetType {
    var baseURL: URL { return URL(string: "https://qint-server.xquare.app/questions")! }
    
    var path: String {
        switch self {
        case .getQuestions:
            return "/categories"
        case .judge:
            return "/judge"
        case .next:
            return "/move-to-next-problem"
        case .home:
            return "/move-to-home"
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
        case let .next(move_to_next_problem, _):
            return .requestParameters(
                parameters: [
                    "move_to_next_problem": move_to_next_problem
                ],
                encoding: JSONEncoding.default
            )
        case let .home(move_to_home, _):
            return .requestParameters(
                parameters: [
                    "move_to_home": move_to_home
                ],
                encoding: JSONEncoding.default
            )
        }
    }

    
    var headers: [String : String]? {
        switch self {
        case .getQuestions(_, token: let token), .judge(_, _, token: let token), .next(_, token: let token), .home(_, token: let token):
            return ["Authorization": "Bearer " + token]
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
