import UIKit
import SnapKit
import Then

class MainViewController: UIViewController {
    
    let qintLabel = UILabel().then {
        $0.text = "Q-int"
        $0.font = UIFont(name: "ZenDots-Regular", size: 24)
        $0.textColor = UIColor(named: "Gray400")
    }

    let myButton = UIButton().then {
        $0.setImage(UIImage(systemName: "person.fill"), for: .normal)
        $0.tintColor = UIColor(named: "Gray400")
        $0.imageView?.contentMode = .scaleAspectFill
        $0.contentHorizontalAlignment = .fill
        $0.contentVerticalAlignment = .fill
        $0.addTarget(self, action: #selector(myButtonTapped), for: .touchUpInside)
    }
    
    @objc func myButtonTapped() {
        self.navigationController?.pushViewController(MyViewController(), animated: true)
    }
    
    private let feButton = CategoryButton(type: .fe)
    private let beButton = CategoryButton(type: .be)
    private let iosButton = CategoryButton(type: .ios)
    private let flutterButton = CategoryButton(type: .flutter)
    
    let categoryLabel = UILabel().then {
        $0.text = "카테고리를 한 개 이상 선택해주세요!"
        $0.textColor = UIColor(named: "Gray400")
    }
    
    let startButton = UIButton().then {
        $0.QintButton(setTitle: "시작하기", setTitleColor: "White", buttonColor: "Mint300")
        $0.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc func startButtonTapped() {
        print("시작하기")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        attribute()
        add()
        layout()
    }
    
    func attribute() {
        view.backgroundColor = .white
    }
    
    func add() {
        [
            qintLabel,
            myButton,
            feButton,
            beButton,
            iosButton,
            flutterButton,
            categoryLabel,
            startButton
        ].forEach{ view.addSubview($0) }
    }
    
    func layout() {
        qintLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(71)
            $0.left.equalToSuperview().inset(30)
        }
        myButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(71)
            $0.right.equalToSuperview().inset(30)
            $0.height.width.equalTo(25)
        }
        feButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(84)
        }
        beButton.snp.makeConstraints {
            $0.top.equalTo(feButton.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(84)
        }
        iosButton.snp.makeConstraints {
            $0.top.equalTo(beButton.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(84)
        }
        flutterButton.snp.makeConstraints {
            $0.top.equalTo(iosButton.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(84)
        }
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(flutterButton.snp.bottom).offset(24)
            $0.left.equalToSuperview().inset(24)
        }
        startButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(48)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }
    }
}
