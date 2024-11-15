import UIKit
import SnapKit
import Then
import Moya

class SignUpViewController: UIViewController {
    
    private let authPrvoider = MoyaProvider<AuthAPI>()
    private let emailProvoider = MoyaProvider<EmailAPI>()
    
    private let signUpLabel = UILabel().then {
        $0.text = "회원가입"
        $0.textColor = UIColor(named: "Mint300")
        $0.font = .systemFont(ofSize: 30, weight: .bold)
    }
    
    private let emailTextField = AuthTextField(type: .email)
    
    private let sendButton = UIButton().then {
        $0.setTitle("Send", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(named: "Mint300")
        $0.layer.cornerRadius = 5
        $0.isEnabled = false
    }
    
    private let checkButton = UIButton().then {
        $0.setTitle("Check", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(named: "Mint300")
        $0.layer.cornerRadius = 5
        $0.isEnabled = false
    }
    
    private let authenticationTextField = AuthTextField(type: .authentication)
    private let pwdTextField = AuthTextField(type: .pwd)
    private let pwdConfirmTextField = AuthTextField(type: .confirmpwd)
    
    private let signUpButton = UIButton().then {
        $0.qintButton(setTitle: "회원가입", setTitleColor: "White", buttonColor: "Mint300")
    }
    
    private let goLoginButton = UIButton().then {
        $0.qintButton(setTitle: "로그인하러 가기", setTitleColor: "Mint300", buttonColor: "Mint100")
    }
    
    @objc private func goLoginButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    private let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        add()
        layout()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    private func attribute() {
        view.backgroundColor = .white
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        goLoginButton.addTarget(self, action: #selector(goLoginButtonTapped), for: .touchUpInside)
        
        emailTextField.textField.delegate = self
        pwdTextField.textField.delegate = self
        pwdConfirmTextField.textField.delegate = self
    }
    
    private func add() {
        [
            signUpLabel,
            emailTextField,
            sendButton,
            checkButton,
            authenticationTextField,
            pwdTextField,
            pwdConfirmTextField,
            signUpButton,
            goLoginButton
        ].forEach{ view.addSubview($0) }
        view.addGestureRecognizer(tap)
    }
    
    private func layout() {
        signUpLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.centerX.equalToSuperview()
        }
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(signUpLabel.snp.bottom).offset(45)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }
        sendButton.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(40)
            $0.right.equalToSuperview().inset(24)
            $0.height.equalTo(32)
            $0.width.equalTo(66)
        }
        authenticationTextField.snp.makeConstraints {
            $0.top.equalTo(sendButton.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }
        checkButton.snp.makeConstraints {
            $0.top.equalTo(authenticationTextField.snp.bottom).offset(40)
            $0.right.equalToSuperview().inset(24)
            $0.height.equalTo(32)
            $0.width.equalTo(66)
        }
        pwdTextField.snp.makeConstraints {
            $0.top.equalTo(checkButton.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }
        pwdConfirmTextField.snp.makeConstraints {
            $0.top.equalTo(pwdTextField.snp.bottom).offset(40)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }
        signUpButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(124)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }
        goLoginButton.snp.makeConstraints {
            $0.top.equalTo(signUpButton.snp.bottom).offset(7)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }
    }
    
    @objc private func sendButtonTapped() {
        emailProvoider.request(.verify(email: emailTextField.textField.text!)) { response in
            switch response {
            case let .success(response):
                do {
                    switch response.statusCode {
                    case 200:
                        let email = try JSONDecoder().decode(EmailVerify.self, from: response.data)
                        if email.success {
                            self.sendEmail()
                        } else {
                            self.textFieldAppearance(self.emailTextField.textField, color: "Red100", message: "이미 가입된 이메일 입니다.")
                        }
                    default:
                        self.textFieldAppearance(self.emailTextField.textField, color: "Red100", message: "이메일 형식이 일치하지 않습니다.")
                    }
                } catch {
                    
                    print("catch :: \(error.localizedDescription)")
                }
            case let .failure(error):
                print("fail :: \(error.localizedDescription)")
            }
        }
    }
    
    private func sendEmail() {
        emailProvoider.request(.sendAuthCode(email: emailTextField.textField.text!)) { response in
            switch response {
            case let .success(response):
                switch response.statusCode {
                case 200:
                    self.textFieldAppearance(self.emailTextField.textField, color: "Mint300", message: "인증 코드가 발송되었습니다.")
                    self.checkButton.isEnabled = true
                default:
                    self.textFieldAppearance(self.emailTextField.textField, color: "Red100", message: "인증 코드가 발송되지 않았습니다.")
                }
            case let .failure(error):
                print("fail :: \(error.localizedDescription)")
            }
        }
    }
    
    @objc private func checkButtonTapped() {
        emailProvoider.request(.checkAuthCode(email: emailTextField.textField.text!, auth_code: authenticationTextField.textField.text!)) { response in
            switch response {
            case let .success(response):
                do {
                    switch response.statusCode {
                    case 200:
                        let email = try JSONDecoder().decode(AuthCodeCheck.self, from: response.data)
                        if email.isVerified {
                            self.textFieldAppearance(self.authenticationTextField.textField, color: "Mint300", message: "인증 코드가 일치합니다.")
                        } else {
                            self.textFieldAppearance(self.authenticationTextField.textField, color: "Red100", message: "인증 코드가 일치하지 않습니다.")
                        }
                    default:
                        print("잘못된 인증 코드 :: \(response.statusCode)")
                    }
                } catch {
                    print("catch: \(error.localizedDescription)")
                }
            case let .failure(error):
                print("fail :: \(error.localizedDescription)")
            }
        }
    }
    
    @objc private func signUpButtonTapped() {
        if emailTextField.textField.layer.borderColor == UIColor.mint300.cgColor && authenticationTextField.textField.layer.borderColor ==  UIColor.mint300.cgColor && pwdTextField.textField.layer.borderColor ==  UIColor.mint300.cgColor && pwdConfirmTextField.textField.layer.borderColor ==  UIColor.mint300.cgColor {
            authPrvoider.request(.signup(password: pwdTextField.textField.text!, email: emailTextField.textField.text!)) { response in
                switch response {
                case let .success(response):
                    switch response.statusCode {
                    case 200:
                        self.dismiss(animated: true)
                    default:
                        print("회원가입 실패 \(response.statusCode)")
                    }
                case let .failure(error):
                    print("fail :: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func isValidEmail(email: String) -> Bool {
        let regExp = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", regExp)
        return passwordTest.evaluate(with: email)
    }
    
    private func isValidPwd(pwd: String) -> Bool {
        let reGex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^&*()\\-_=+<>?]).{8,64}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", reGex)
        return passwordTest.evaluate(with: pwd)
    }
    
    private func textFieldAppearance(_ textField: UITextField, color: String, message: String?) {
        textField.layer.borderColor = UIColor(named: color)?.cgColor
        textField.layer.borderWidth = 1
        if let messageLabel = (textField.superview as? AuthTextField)?.label {
            messageLabel.text = message
            messageLabel.textColor = UIColor(named: color)
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = (textField.superview as? AuthTextField)?.currentText(), !text.isEmpty else {
            textFieldAppearance(textField, color: "Red100", message: textField == emailTextField.textField ? "이메일을 입력해주세요" : "영어, 숫자, 특수기호를 모두 포함한 8~64 문자 사이의 비밀번호")
            return
        }
        
        switch textField {
        case emailTextField.textField:
            if isValidEmail(email: text) {
                textFieldAppearance(textField, color: "Mint300", message: "사용 가능한 이메일입니다.")
                sendButton.isEnabled = true
            } else {
                textFieldAppearance(textField, color: "Red100", message: "이메일 형식이 일치하지 않습니다.")
            }
            
        case pwdTextField.textField:
            if isValidPwd(pwd: text) {
                textFieldAppearance(textField, color: "Mint300", message: "사용 가능한 비밀번호입니다.")
            } else {
                textFieldAppearance(textField, color: "Red100", message: "비밀번호 형식은 영어, 숫자, 특수기호를 모두 한 개 이상 포함한 8~64 문자입니다.")
            }
            
        case pwdConfirmTextField.textField:
            if text == pwdTextField.currentText() {
                textFieldAppearance(textField, color: "Mint300", message: "비밀번호가 일치합니다.")
            } else {
                textFieldAppearance(textField, color: "Red100", message: "비밀번호가 일치하지 않습니다")
            }
        default:
            break
        }
    }
}
