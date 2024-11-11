import UIKit

enum ErrorModel: Error {
    case DoNotEnterEmail(email: String)
    case EmailIsValid(email: String)
    case EmailNotValid(email: String)
    case DoNotEnterPwd
    case PwdIsValid
    case PwdNotValid
    case DoNotEnterPwdConfirm
    case PwdConfirmIsValid
    case PwdConfirmNotValid
    
    var localizedDescription: String {
        switch self {
        case .DoNotEnterEmail:
            return "사용자가 이메일을 입력하지 않음"
        case .EmailIsValid:
            return "이메일이 유효함"
        case .EmailNotValid:
            return "이메일이 유효하지 않음"
        case .DoNotEnterPwd:
            return "사용자가 비밀번호를 입력하지 않음"
        case .PwdIsValid:
            return "비밀번호가 유효함"
        case .PwdNotValid:
            return "비밀번호가 유효하지 않음"
        case .DoNotEnterPwdConfirm:
            return "사용자가 비밀번호 재확인을 입력하지 않음"
        case .PwdConfirmIsValid:
            return "비밀번호가 일치함"
        case .PwdConfirmNotValid:
            return "비밀번호가 일치하지 않음"
        }
    }
}
