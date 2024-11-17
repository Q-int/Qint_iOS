import UIKit
import SnapKit
import Then
import Moya

class MainViewController: UIViewController {
    
    private let questionPrvoider = MoyaProvider<QuestionAPI>()
    
    private var categoryButtonNumber = 0
    private var request = [String]()
    
    private let qintLabel = UILabel().then {
        $0.text = "Q-int"
        $0.font = UIFont(name: "ZenDots-Regular", size: 24)
        $0.textColor = UIColor(named: "Gray400")
    }
    
    private let myButton = UIButton().then {
        $0.iconButton()
        $0.setImage(UIImage(systemName: "person.fill"), for: .normal)
    }
    
    @objc private func myButtonTapped() {
        self.navigationController?.pushViewController(MyViewController(), animated: true)
    }
    
    private let feButton = CategoryButton(type: .fe)
    private let beButton = CategoryButton(type: .be)
    private let iosButton = CategoryButton(type: .ios)
    private let flutterButton = CategoryButton(type: .flutter)
    
    private let categoryLabel = UILabel().then {
        $0.text = "카테고리를 한 개 이상 선택해주세요!"
        $0.textColor = UIColor(named: "Gray400")
    }
    
    private let startButton = UIButton().then {
        $0.isHidden = true
        $0.qintButton(setTitle: "시작하기", setTitleColor: "White", buttonColor: "Mint300")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        attribute()
        add()
        layout()
    }
    
    private func attribute() {
        view.backgroundColor = .white
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        myButton.addTarget(self, action: #selector(myButtonTapped), for: .touchUpInside)
        
        [
            feButton.button,
            beButton.button,
            iosButton.button,
            flutterButton.button
        ].forEach{ button in
            button.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
        }
    }
    
    private func add() {
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
        view.addSubview(qintLabel)
    }
    
    private func layout() {
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
    @objc private func categoryButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        if sender.isSelected {
            sender.layer.borderColor = UIColor(named: "Mint300")?.cgColor
            sender.layer.borderWidth = 2
            sender.backgroundColor = UIColor(named: "Mint200")
            startButton.isHidden = false
            categoryButtonNumber += 1
            request.append(sender.titleLabel?.text ?? "")
            categoryLabel.isHidden = true
        } else {
            sender.layer.borderColor = UIColor.clear.cgColor
            sender.layer.borderWidth = 0
            sender.backgroundColor = UIColor(named: "Mint100")
            categoryButtonNumber -= 1
            let index = request.firstIndex(of: sender.titleLabel?.text ?? "")
            request.remove(at: index ?? 0)
            if categoryButtonNumber == 0 {
                startButton.isHidden = true
                categoryLabel.isHidden = false
            }
        }
    }
    @objc private func startButtonTapped() {
        questionPrvoider.request(.getQuestions(categories: request, token: Token.accessToken ?? "")) { response in
            switch response {
            case let .success(response):
                switch response.statusCode {
                case 200:
                    do {
                        let decoder = JSONDecoder()
                        let questionsResponse = try decoder.decode(QuestionsResponse.self, from: response.data)
                        let vc = QuestionViewController()
                        self.navigationController?.pushViewController(vc, animated: true)
                        vc.questionsArray = questionsResponse.questions
                    } catch {
                        print("Decoding or JSON parsing error: \(error)")
                    }
                default:
                    if let errorMessage = String(data: response.data, encoding: .utf8) {
                        print("실패 :: Error Message: \(errorMessage)")
                    } else {
                        print("실패 :: \(response.statusCode), Error Message: 데이터 변환 실패")
                    }
                }
                
            case let .failure(error):
                print("에러 :: \(error.localizedDescription)")
            }
        }
    }
    
}
