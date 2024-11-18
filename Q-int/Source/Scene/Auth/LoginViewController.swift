import UIKit
import Moya
import SnapKit
import Then

class LoginViewController: UIViewController {
    private let authProvider = MoyaProvider<AuthAPI>()
    
    private let loginLabel = UILabel().then {
        $0.text = "로그인"
        $0.textColor = UIColor.mint300
        $0.font = .systemFont(ofSize: 30, weight: .bold)
    }
    
    private let emailTextField = AuthTextField(type: .email)
    private let pwdTextField = AuthTextField(type: .pwd)
    
    private let errorLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 10)
        $0.textColor = UIColor.red100
        $0.text = "이메일 또는 비밀번호가 일치하지 않습니다"
        $0.isHidden = true
    }
    
    private let loginButton = UIButton().then {
        $0.qintButton(setTitle: "로그인", setTitleColor: "White", buttonColor: "Mint300")
    }
    
    private let goSignUpButton = UIButton().then {
        $0.qintButton(setTitle: "회원가입하러 가기", setTitleColor: "Mint300", buttonColor: "Mint100")
    }
    
    private let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing))
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Token.accessToken != nil {
            self.navigationController?.pushViewController(MainViewController(), animated: false)
        } else {
            print("로그아웃 상태입니다.")
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        add()
        layout()
    }
    
    private func attribute() {
        view.backgroundColor = .white
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        goSignUpButton.addTarget(self, action: #selector(goSignUpButtonTapped), for: .touchUpInside)
    }
    
    private func add() {
        [
            loginLabel,
            emailTextField,
            pwdTextField,
            errorLabel,
            loginButton,
            goSignUpButton,
        ].forEach{ view.addSubview($0) }
        view.addGestureRecognizer(tap)
    }
    
    private func layout() {
        loginLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.centerX.equalToSuperview()
        }
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(loginLabel.snp.bottom).offset(45)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }
        pwdTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(40)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }
        errorLabel.snp.makeConstraints {
            $0.bottom.equalTo(loginButton.snp.top).inset(-10)
            $0.centerX.equalToSuperview()
        }
        loginButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(124)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }
        goSignUpButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(7)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    @objc private func loginButtonTapped() {
        authProvider.request(.login(email: emailTextField.textField.text ?? "이메일이 입력되지 않음", password: pwdTextField.textField.text ?? "비밀번호가 입력되지 않음")) { response in
            switch response {
            case let .success(response):
                do {
                    switch response.statusCode {
                    case 200:
                        let decodeResponse = try JSONDecoder().decode(TokenResponse.self, from: response.data)
                        Token.accessToken = decodeResponse.accessToken
                        Token.refreshToken = decodeResponse.refreshToken
                        let vc = MainViewController()
                        let navigationController = self.navigationController
                        navigationController?.setViewControllers([vc], animated: true)
                        self.errorLabel.isHidden = true
                    default:
                        self.errorLabel.isHidden = false
                        self.emailTextField.textField.layer.borderColor = UIColor.red100.cgColor
                        self.emailTextField.textField.layer.borderWidth = 1
                        self.pwdTextField.textField.layer.borderColor = UIColor.red100.cgColor
                        self.pwdTextField.textField.layer.borderWidth = 1
                    }
                } catch {
                    print("catch :: \(error.localizedDescription)")
                }
            case let .failure(errror):
                print("fail :: \(errror.localizedDescription)")
            }
        }
    }
    
    @objc private func goSignUpButtonTapped() {
        let next = SignUpViewController()
        next.modalPresentationStyle = .fullScreen
        
        let transition = CATransition().then {
            $0.duration = 0.5
            $0.type = .fade
            $0.subtype = .fromTop
        }
        
        view.window?.layer.add(transition, forKey: kCATransition)
        
        present(next, animated: true, completion: nil)
    }
}
