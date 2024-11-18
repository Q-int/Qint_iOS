import UIKit
import SnapKit
import Then
import Moya

enum UserAPI {
    case info(token: String)
    case incorrect(token: String)
}

extension UserAPI: TargetType {
    var baseURL: URL { .init(string: "https://qint-server.xquare.app/users")! }
    
    var path: String {
        switch self {
        case .info: 
            return "/info"
        case .incorrect:
            return "/incorrect-problems"
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
        case .info(token: let token), .incorrect(token: let token):
            return ["Authorization": "Bearer " + token]
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
