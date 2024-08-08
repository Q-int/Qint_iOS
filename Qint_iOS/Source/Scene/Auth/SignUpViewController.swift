import UIKit
import SnapKit
import Then

class SignUpViewController: UIViewController {
    
    let signUpLabel = UILabel().then {
        $0.text = "회원가입"
        $0.textColor = UIColor(named: "Mint300")
        $0.font = .systemFont(ofSize: 30, weight: .bold)
    }
    
    private let emailTextField = AuthTextField(type: .email)
    
    let sendButton = UIButton().then {
        $0.setTitle("Send", for: .normal)
        
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(named: "Mint300")
        $0.layer.cornerRadius = 5
    }
    
    private let authenticationTextField = AuthTextField(type: .authentication)
    private let pwdTextField = AuthTextField(type: .pwd)
    private let pwdConfirmTextField = AuthTextField(type: .confirmpwd)
    
    let signUpButton = UIButton().then {
        $0.QintButton(setTitle: "회원가입", setTitleColor: "White", buttonColor: "Mint300")
        $0.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    @objc func signUpButtonTapped() {
        print("회원가입")
    }
    
    let goLoginButton = UIButton().then {
        $0.QintButton(setTitle: "로그인하러 가기", setTitleColor: "Mint300", buttonColor: "Mint100")
        $0.addTarget(self, action: #selector(goLoginButtonTapped), for: .touchUpInside)
    }
    
    @objc func goLoginButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        add()
        layout()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
     
        self.view.endEditing(true)
    }
    
    func attribute() {
        view.backgroundColor = .white
    }
    
    func add() {
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
    
    func layout() {
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
}

