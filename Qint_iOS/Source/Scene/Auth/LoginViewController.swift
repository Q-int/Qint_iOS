import UIKit
import Moya
import SnapKit
import Then

class LoginViewController: UIViewController {
    
    private let authPrvoider = MoyaProvider<AuthAPI>()
    
    private let loginLabel = UILabel().then {
        $0.text = "로그인"
        $0.textColor = UIColor(named: "Mint300")
        $0.font = .systemFont(ofSize: 30, weight: .bold)
    }
    
    private let emailTextField = AuthTextField(type: .email)
    private let pwdTextField = AuthTextField(type: .pwd)
    
    private let loginButton = UIButton().then {
        $0.qintButton(setTitle: "로그인", setTitleColor: "White", buttonColor: "Mint300")
    }
    
    private let goSignUpButton = UIButton().then {
        $0.qintButton(setTitle: "회원가입하러 가기", setTitleColor: "Mint300", buttonColor: "Mint100")
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
    
    func attribute() {
        view.backgroundColor = .white
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        goSignUpButton.addTarget(self, action: #selector(goSignUpButtonTapped), for: .touchUpInside)
    }
    
    func add() {
        [
            loginLabel,
            emailTextField,
            pwdTextField,
            loginButton,
            goSignUpButton,
        ].forEach{ view.addSubview($0) }
        view.addGestureRecognizer(tap)
    }
    
    func layout() {
        
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
    
    @objc private func loginButtonTapped() {
        print("로그인")
        authPrvoider.request(.login(email: emailTextField.textField.text ?? "이메일이 입력되지 않음", password: pwdTextField.textField.text ?? "비밀번호가 입력되지 않음")) { response in
            switch response {
            case let .success(response):
                switch response.statusCode {
                case 200:
                    if let data = try? JSONDecoder().decode(TokenResponse.self, from: response.data) {
                        DispatchQueue.main.async {
                            Token.accessToken = data.accessToken
                            print(Token.accessToken)
                            let mainViewController = MainViewController()
                            let navigationController = self.navigationController
                            navigationController?.setViewControllers([mainViewController], animated: true)
                        }
                    } else {
                        print("auth json decode fail")
                    }
                    print("로그인 성공")
                case 400:
                    print("이메일 또는 비밀번호 불일치")
                default:
                    print("존재하지 않는 유저")
                }
            case let .failure(errror):
                print("(err.localizedDescription)")
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
