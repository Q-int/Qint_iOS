import UIKit
import SnapKit
import Then

enum AnswerBtType {
    case question
    case correct
    case wrong
}

class AnswerButton: UIView {
    let answerLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 25)
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.1
    }
    let answerButton = UIButton().then {
        $0.backgroundColor = UIColor(named: "Mint100")
        $0.layer.cornerRadius = 10
    }
    init(type: AnswerBtType){
        super.init(frame: .zero)
        
        if type == .correct {
            answerButton.layer.borderColor = UIColor(named: "Green100")?.cgColor
            answerButton.layer.borderWidth = 3
        } else if type == .wrong {
            answerButton.layer.borderColor = UIColor(named: "Red100")?.cgColor
            answerButton.layer.borderWidth = 3
        }
        
        add()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func add() {
        self.addSubview(answerButton)
        answerButton.addSubview(answerLabel)
    }
    private func layout() {
        answerButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        answerLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
