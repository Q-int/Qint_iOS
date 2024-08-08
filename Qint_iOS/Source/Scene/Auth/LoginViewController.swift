import UIKit
import SnapKit
import Then

class LoginViewController: UIViewController {
    
    let loginLabel = UILabel().then {
        $0.text = "로그인"
        $0.textColor = UIColor(named: "Mint300")
        $0.font = .systemFont(ofSize: 30, weight: .bold)
    }
    
    private let emailTextField = AuthTextField(type: .email)
    private let pwdTextField = AuthTextField(type: .pwd)
    
    let loginButton = UIButton().then {
        $0.QintButton(setTitle: "로그인", setTitleColor: "White", buttonColor: "Mint300")
    }
    
    let goSignUpButton = UIButton().then {
        $0.QintButton(setTitle: "회원가입하러 가기", setTitleColor: "Mint300", buttonColor: "Mint100")
        $0.addTarget(self, action: #selector(goSignUpButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func goSignUpButtonTapped() {
        let next = SignUpViewController()
        next.modalPresentationStyle = .fullScreen
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .fade
        transition.subtype = .fromTop
        view.window?.layer.add(transition, forKey: kCATransition)
        
        present(next, animated: true, completion: nil)
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
    
}
