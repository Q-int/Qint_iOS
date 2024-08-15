import UIKit
import Moya

enum AuthAPI: TargetType {
    case login(email: String, password: String)
    case emailVerify(email: String)
    case signup(password: String, passwordCheck: String, email: String)
}

extension AuthAPI {
    var baseURL: URL { return URL(string: "http://")! }
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .emailVerify:
            return "/auth/email-verify"
        case .signup:
            return "/auth/signup"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login :
            return .post
        case .emailVerify:
            return .post
        case .signup:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .login(email: email, password: password):
            return .requestParameters(
                parameters: [
                    "email": email,
                    "password": password
                ],
                encoding: JSONEncoding.default
            )
        case let .emailVerify(email: email):
            return .requestParameters(
                parameters: [
                    "email": email
                ],
                encoding: JSONEncoding.default
            )
        case let .signup(password: password, passwordCheck: passwordCheck, email: email):
            return .requestParameters(
                parameters: [
                    "password": password,
                    "passwordCheck": passwordCheck,
                    "email": email
                ],
                encoding: JSONEncoding.default
            )
        default:
            return .requestPlain
        }
    }
    var headers: [String: String]? {
        return nil
    }
}

