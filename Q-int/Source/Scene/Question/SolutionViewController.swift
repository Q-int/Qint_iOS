import UIKit
import SnapKit
import Then

class SolutionViewController: UIViewController {
    public var solutionIndex: Int = 0
    
    private let cancelButton = UIButton().then {
        $0.setImage(UIImage(named: "X"), for: .normal)
    }
    private let questionView = UIView().then {
        $0.questionView()
    }
    private let questionLabel = UILabel().then {
        $0.questionLabel()
    }
    lazy var indexLabel = UILabel().then {
        $0.text = "\(solutionIndex+1)/15"
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = UIColor(named: "Gray400")
    }
    private let correctButton = AnswerButton(type: .correct)
    private let solutionView = UIView().then {
        $0.backgroundColor = UIColor(named: "Mint100")
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = false
    }
    private let solutionLabel = UILabel().then {
        $0.solutionLabel()
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
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
    }
    
    private func add() {
        [
            cancelButton,
            questionView,
            indexLabel,
            correctButton,
            solutionView,
        ].forEach{ view.addSubview($0) }
        questionView.addSubview(questionLabel)
        solutionView.addSubview(solutionLabel)
    }
    
    private func layout() {
        cancelButton.snp.makeConstraints {
            $0.top.right.equalToSuperview().inset(24)
            $0.height.width.equalTo(20)
        }
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
        solutionView.snp.makeConstraints {
            $0.top.equalTo(correctButton.snp.bottom).offset(25)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(250)
        }
        solutionLabel.snp.makeConstraints {
            $0.top.right.left.equalToSuperview().inset(15)
        }
    }
    
    @objc func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
}
