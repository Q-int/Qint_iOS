import UIKit
import SnapKit
import Then
import Moya

enum UserAPI {
    case info(token: String)
}

extension UserAPI: TargetType {
    var baseURL: URL { .init(string: "http://192.168.143.87:8080")! }
    
    var path: String {
        switch self {
        case .info: 
            return "/users/info"
        }
    }
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        switch self {
        case .info(token: let token):
            return ["Authorization": "Bearer " + token]
        }
    }
}
