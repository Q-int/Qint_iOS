import UIKit
import Moya

enum AuthAPI: TargetType {
    case login(email: String, password: String)
}

extension AuthAPI {
    var baseURL: URL { return URL(string: "http://")! }
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login :
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
        default:
            return .requestPlain
        }
    }
    var headers: [String: String]? {
        return nil
    }
}

