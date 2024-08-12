import UIKit
import SnapKit
import Then

class SignUpViewController: UIViewController {
    
    private let signUpLabel = UILabel().then {
        $0.text = "회원가입"
        $0.textColor = UIColor(named: "Mint300")
        $0.font = .systemFont(ofSize: 30, weight: .bold)
    }
    
    private let emailTextField = AuthTextField(type: .email)
    
    private let sendButton = UIButton().then {
        $0.setTitle("Send", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(named: "Mint300")
        $0.layer.cornerRadius = 5
        $0.isEnabled = false
    }
    
    private let authenticationTextField = AuthTextField(type: .authentication)
    private let pwdTextField = AuthTextField(type: .pwd)
    private let pwdConfirmTextField = AuthTextField(type: .confirmpwd)
    
    private let signUpButton = UIButton().then {
        $0.QintButton(setTitle: "회원가입", setTitleColor: "White", buttonColor: "Mint300")
    }
    
    private let goLoginButton = UIButton().then {
        $0.QintButton(setTitle: "로그인하러 가기", setTitleColor: "Mint300", buttonColor: "Mint100")
    }
    
    @objc private func goLoginButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    private let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if emailTextField.TFEditing == false {
            guard let email = emailTextField.currentText(), email.count != 0 else {
                print("이메일 입력 안함")
                return
            }
            if isValidEmail(email: email) {
                print("유효한 이메일")
                sendButton.isEnabled = true
            }
            else { print("유효하지 않은 이메일") }
        }
        
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
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        goLoginButton.addTarget(self, action: #selector(goLoginButtonTapped), for: .touchUpInside)
    }
    
    private func add() {
        [
            signUpLabel,
            emailTextField,
            sendButton,
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
        pwdTextField.snp.makeConstraints {
            $0.top.equalTo(authenticationTextField.snp.bottom).offset(40)
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
        print("send버튼 눌림")
    }
    
    @objc private func signUpButtonTapped() {
//        guard let email = emailTextField.currentText(), email.count != 0 else {
//            print("이메일 입력 안함")
//            return
//        }
//        if isValidEmail(email: email) {
//            print("유효한 이메일")
//            sendButton.isEnabled = true
//        }
//        else { print("유효하지 않은 이메일") }
        
        guard let pwd = pwdTextField.currentText(), pwd.count != 0 else {
            print("비밀번호 입력 안함")
            return
        }
        if isValidPwd(pwd: pwd) { print("유효한 비밀번호") }
        else { print("유효하지 않은 비밀번호") }
        
        if pwdTextField.currentText() == pwdConfirmTextField.currentText() {
            print("비밀번호 일치")
        } else { print("비밀번호 일치하지 않음") }
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
}

