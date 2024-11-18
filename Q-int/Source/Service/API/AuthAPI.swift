import UIKit
import Moya

enum AuthAPI: TargetType {
    case login(email: String, password: String)
    case signup(password: String, email: String)
    case refresh(refreshToken: String)
}

extension AuthAPI {
    var baseURL: URL { return URL(string: "http://192.168.1.30:8080/auth")! }
    
    var path: String {
        switch self {
        case .login:
            return "/login"
        case .signup:
            return "/signup"
        case .refresh:
            return "/refresh"
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
        case let .refresh(refreshToken: refreshToken):
            return .requestParameters(
                parameters: [
                    "refreshToken": refreshToken
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
