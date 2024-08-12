import Foundation
import UIKit
import Moya

enum UserAPI {
    case login(email: String, password: String)
}

extension UserAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://")!
    }
    
    var path: String {
        switch self {
        case .login:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
            
        case let .login(email, password):
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


