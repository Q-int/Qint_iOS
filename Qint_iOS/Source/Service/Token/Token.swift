import Foundation

struct Token {
    static var saveAccessToken: String?
    static var accessToken: String? {
        get {
           saveAccessToken = UserDefaults.standard.string(forKey: "accessToken")
           return saveAccessToken
        }

        set(newToken) {
            UserDefaults.standard.set(newToken, forKey: "accessToken")
            UserDefaults.standard.synchronize()
            saveAccessToken = UserDefaults.standard.string(forKey: "accessToken")
        }
    }

    static var saveRefreshToken: String?
    static var refreshToken: String? {
        get {
            saveRefreshToken = UserDefaults.standard.string(forKey: "refreshToken")
            return saveRefreshToken
        }

        set(newRefreshToken) {
            UserDefaults.standard.set(newRefreshToken, forKey: "refreshToken")
            UserDefaults.standard.synchronize()
            saveRefreshToken = UserDefaults.standard.string(forKey: "refreshToken")
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
            return ["Contect-Type": "application/json"]
        }

        guard let refreshToken = Token.refreshToken else {
            return ["Contect-Type": "application/json"]
        }

        switch self {
        case .accessToken:
            print(token)
            return ["Authorization": "Barrer " + token]
        case .refreshToken:
            return ["Authorization": "Bearer " + token,
                    "Refresh-Token": refreshToken, "Contect-Type": "application/json"]
        case .tokenIsEmpty:
            return ["Contect-Type": "application/json"]
        case .uploadImage:
            return ["Authorization": "Bearer " + token, "Content-Type": "multipart/form-data"]
        }
    }
}

