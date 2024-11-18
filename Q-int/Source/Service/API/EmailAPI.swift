import UIKit
import Moya

enum EmailAPI: TargetType {
    case verify(email: String)
    case sendAuthCode(email: String)
    case checkAuthCode(email: String, auth_code: String)
}

extension EmailAPI {
    var baseURL: URL { return URL(string: "https://qint-server.xquare.app/email")! }
    
    var path: String {
        switch self {
        case .verify:
            return "/email-verify"
        case .sendAuthCode:
            return "/send-authcode"
        case .checkAuthCode:
            return "/check-authcode"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .verify(email):
            return .requestParameters(
                parameters: [
                    "email": email
                ],
                encoding: JSONEncoding.default
            )
        case let .sendAuthCode(email):
            return .requestParameters(
                parameters: [
                    "email": email
                ],
                encoding: JSONEncoding.default
            )
        case let .checkAuthCode(email, auth_code):
            return .requestParameters(
                parameters: [
                    "email": email,
                    "auth_code": auth_code
                ],
                encoding: JSONEncoding.default
            )
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
