import Foundation

struct Token {
    static var saveAccessToken: String?
    static var accessToken: String? {
        get {
           saveAccessToken = UserDefaults.standard.string(forKey: "access_token")
           return saveAccessToken
        }

        set(newToken) {
            UserDefaults.standard.set(newToken, forKey: "access_token")
            UserDefaults.standard.synchronize()
            saveAccessToken = UserDefaults.standard.string(forKey: "access_token")
        }
    }

    static var saveRefreshToken: String?
    static var refreshToken: String? {
        get {
            saveRefreshToken = UserDefaults.standard.string(forKey: "refresh_token")
            return saveRefreshToken
        }

        set(newRefreshToken) {
            UserDefaults.standard.set(newRefreshToken, forKey: "refresh_token")
            UserDefaults.standard.synchronize()
            saveRefreshToken = UserDefaults.standard.string(forKey: "refresh_token")
        }
    }

    static func removeToken() {
        accessToken = nil
        refreshToken = nil
    }
}

enum Header {
    case accessToken, tokenIsEmpty, refreshToken, uploadImage

    func header() -> [String: String]? {
        guard let token = Token.accessToken else {
            return ["Content-Type": "application/json"]
        }

        guard let refreshToken = Token.refreshToken else {
            return ["Content-Type": "application/json"]
        }

        switch self {
        case .accessToken:
            print(token)
            return ["Authorization": "Bearer " + token]
        case .refreshToken:
            return [
                "X-Refresh-Token": refreshToken,
                "Content-Type": "application/json"
            ]
        case .tokenIsEmpty:
            return ["Content-Type": "application/json"]
        case .uploadImage:
            return ["Authorization": "Bearer " + token, "Content-Type": "multipart/form-data"]
        }
    }
}
