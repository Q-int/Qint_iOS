import Alamofire
import Moya
import UIKit

class AuthInterceptor: RequestInterceptor {
    static let shared = AuthInterceptor()
    
    let provider = MoyaProvider<AuthAPI>(plugins: [MoyaLoggingPlugin()])
    private init() { }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard urlRequest.url?.absoluteString.hasPrefix("https://qint-server.xquare.app") == true,
              let refreshToken = Token.refreshToken
        else {
            completion(.success(urlRequest))
            return
        }
        
        var urlRequest = urlRequest
        urlRequest.setValue(refreshToken, forHTTPHeaderField: "X-Refresh-Token")
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("retry 진입")
            guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401
        else {
            completion(.doNotRetryWithError(error))
            return
        }
        provider.request(.refresh(refreshToken: Token.refreshToken ?? "")) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...299:
                    if let data = try? JSONDecoder().decode(TokenResponse.self, from: result.data) {
                        print("Success To refresh")
                        Token.accessToken = data.accessToken
                        Token.refreshToken = data.refreshToken
                        DispatchQueue.main.async {
                            completion(.retry)
                        }
                    } else {
                        print("status code: \(result.statusCode)")
                    }
                default:
                    print("Failed To refresh")
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
}
