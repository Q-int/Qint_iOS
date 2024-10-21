import UIKit
import SnapKit
import Then

class SolutionViewController: UIViewController {
    private var solutionIndex: Int = 0
    
    private let questionView = UIView().then {
        $0.questionView()
    }
    
    private let questionLabel = UILabel().then {
        $0.questionLabel()
    }
    
    lazy var indexLabel = UILabel().then {
        $0.text = "\(solutionIndex)/15"
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = UIColor(named: "Gray400")
    }
    
    private let correctButton = UIButton().then {
        $0.answerButton()
        $0.layer.borderColor = UIColor(named: "Green100")?.cgColor
        $0.layer.borderWidth = 3
    }
    
    private let correctLabel = UILabel().then {
        $0.answerLabel()
    }
    
    private let solutionView = UIView().then {
        $0.backgroundColor = UIColor(named: "Mint100")
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = false
    }
    
    private let solutionLabel = UILabel().then {
        $0.answerLabel()
        $0.text = "어쩌구 저쩌구 해서 쨌든 그냥 니가 틀리고 내가 맞음 어쩔팁이"
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.textAlignment = .left
    }
    
    private let mainButton = UIButton().then {
        $0.iconButton()
    }
    
    private let nextButton = UIButton().then {
        $0.nextButton()
    }
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        add()
        layout()
        print("solutionIndex: \(solutionIndex)")
    }
    
    private func attribute() {
        view.backgroundColor = .white
        mainButton.addTarget(self, action: #selector(mainButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    private func add() {
        [
            questionView,
            indexLabel,
            correctButton,
            solutionView,
            mainButton,
            nextButton
        ].forEach{ view.addSubview($0) }
        questionView.addSubview(questionLabel)
        correctButton.addSubview(correctLabel)
        solutionView.addSubview(solutionLabel)
    }
    
    private func layout() {
        questionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(85)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(230)
        }
        questionLabel.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview().inset(15)
        }
        indexLabel.snp.makeConstraints {
            $0.top.equalTo(questionView.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        correctButton.snp.makeConstraints {
            $0.top.equalTo(indexLabel.snp.bottom).offset(25)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(75)
        }
        correctLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
        solutionView.snp.makeConstraints {
            $0.top.equalTo(correctButton.snp.bottom).offset(25)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(250)
        }
        solutionLabel.snp.makeConstraints {
            $0.top.right.left.equalToSuperview().inset(15)
        }
        mainButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(74)
            $0.left.equalToSuperview().inset(24)
            $0.height.width.equalTo(30)
        }
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(64)
            $0.right.equalToSuperview().inset(24)
            $0.height.equalTo(44)
            $0.width.equalTo(105)
        }
    }
    
    @objc private func mainButtonTapped() {
        print("메인버튼")
        self.navigationController?.pushViewController(MainViewController(), animated: true)
    }

    @objc private func nextButtonTapped() {
        let questionViewController = QuestionViewController()
        questionViewController.solIndex = self.solutionIndex
        self.navigationController?.pushViewController(questionViewController, animated: true)
    }
}
