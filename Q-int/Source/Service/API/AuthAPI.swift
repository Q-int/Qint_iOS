import UIKit
import Moya

enum AuthAPI: TargetType {
    case login(email: String, password: String)
    case signup(password: String, email: String)
}

extension AuthAPI {
    var baseURL: URL { return URL(string: "http://192.168.1.84:8080")! }
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .signup:
            return "/auth/signup"
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
        case let .login(email: email, password: password):
            return .requestParameters(
                parameters: [
                    "email": email,
                    "password": password
                ],
                encoding: JSONEncoding.default
            )
        case let .signup(password: password, email: email):
            return .requestParameters(
                parameters: [
                    "password": password,
                    "email": email
                ],
                encoding: JSONEncoding.default
            )
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return Header.tokenIsEmpty.header()
        }
    }
}
