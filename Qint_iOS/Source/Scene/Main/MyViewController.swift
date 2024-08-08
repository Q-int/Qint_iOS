import UIKit
import SnapKit
import Then

class MyViewController: UIViewController {
    
    let qintLabel = UILabel().then {
        $0.text = "Q-int"
        $0.font = UIFont(name: "ZenDots-Regular", size: 24)
        $0.textColor = UIColor(named: "Gray400")
    }
    
    let mainButton = UIButton().then {
        $0.setImage(UIImage(named: "Home2"), for: .normal)
        $0.tintColor = UIColor(named: "Gray400")
        $0.imageView?.contentMode = .scaleAspectFill
        $0.contentHorizontalAlignment = .fill
        $0.contentVerticalAlignment = .fill
        $0.addTarget(self, action: #selector(mainButtonTapped), for: .touchUpInside)
    }
    
    @objc func mainButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    let accuracyView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
    }
    
    let reviewIncorrectLabel = UILabel().then {
        $0.text = "나의 정답률"
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = UIColor(named: "Gray400")
    }
    
    let reviewIncorrectButton = UIButton().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
    }
    
    let reviewIncorrectView = reviewIncorrect()
    
    let emailLabel = UILabel().then {
        $0.text = "오류 신고 이메일 : 1234@dsm.hs.kr"
        $0.font = .systemFont(ofSize: 10)
        $0.textColor = UIColor(named: "Gray400")
    }
    
    let logoutButton = UIButton().then {
        $0.setTitle("로그아웃", for: .normal)
        $0.setTitleColor(UIColor(named: "Gray400"), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 10)
        $0.contentEdgeInsets = UIEdgeInsets(top: -1, left: 0, bottom: -1, right: 0) // 여백 설정
        $0.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    @objc func logoutButtonTapped() {
        print("로그아웃")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        add()
        layout()
    }
    
    func attribute() {
        view.backgroundColor = UIColor(named: "Mint100")
    }
    
    func add() {
        [
            qintLabel,
            mainButton,
            accuracyView,
            reviewIncorrectButton,
            emailLabel,
            logoutButton
        ].forEach{ view.addSubview($0) }
        reviewIncorrectButton.addSubview(reviewIncorrectView)
        accuracyView.addSubview(reviewIncorrectLabel)
    }
    
    func layout() {
        qintLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(71)
            $0.left.equalToSuperview().inset(30)
        }
        mainButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(71)
            $0.right.equalToSuperview().inset(30)
            $0.height.width.equalTo(30)
        }
        accuracyView.snp.makeConstraints {
            $0.top.equalTo(mainButton.snp.bottom).offset(27)
            $0.bottom.equalTo(reviewIncorrectButton.snp.bottom).inset(121)
            $0.left.right.equalToSuperview().inset(24)
        }
        reviewIncorrectLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(24)
        }
        reviewIncorrectButton.snp.makeConstraints {
            $0.bottom.equalTo(emailLabel.snp.bottom).inset(160)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(80)
        }
        reviewIncorrectView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        emailLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(75)
            $0.left.equalToSuperview().inset(24)
        }
        logoutButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(75)
            $0.right.equalToSuperview().inset(24)
        }
    }
    
}
