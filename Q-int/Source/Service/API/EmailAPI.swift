import UIKit
import Moya

enum EmailAPI: TargetType {
    case verify(email: String)
    case sendAuthCode(email: String)
    case checkAuthCode(email: String, authCode: String)
}

extension EmailAPI {
    var baseURL: URL { return URL(string: "https://qint.ijw.app")! }
    
    var path: String {
        switch self {
        case .verify:
            return "/email/email-verify"
        case .sendAuthCode:
            return "/email/send-authcode"
        case .checkAuthCode:
            return "/email/check-authcode"
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
        case let .checkAuthCode(email, authCode):
            return .requestParameters(
                parameters: [
                    "email": email,
                    "authCode": authCode
                ],
                encoding: JSONEncoding.default
            )
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
