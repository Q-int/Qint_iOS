import UIKit
import Moya

enum AuthAPI: TargetType {
    case login(email: String, password: String)
    case signup(password: String, passwordCheck: String, email: String)
    case refreshToken(refreshToken: String)
}

extension AuthAPI {
    var baseURL: URL { return URL(string: "http://")! }
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .signup:
            return "/auth/signup"
        case .refreshToken:
            return "/auth/refresh"
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
        case let .signup(password: password, passwordCheck: passwordCheck, email: email):
            return .requestParameters(
                parameters: [
                    "password": password,
                    "passwordCheck": passwordCheck,
                    "email": email
                ],
                encoding: JSONEncoding.default
            )
        case let .refreshToken(refreshToken: refreshToken):
            return .requestParameters(
                parameters: [
                    "refreshToken": refreshToken
            ],
                encoding: JSONEncoding.default)
        }
    }
    var headers: [String: String]? {
        switch self {
        case .refreshToken:
            return Header.refreshToken.header()
        default:
            return Header.tokenIsEmpty.header()
        }
    }
}

