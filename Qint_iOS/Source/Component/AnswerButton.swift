import UIKit
import SnapKit
import Then

class AnswerButton: UIView {
    let answerLabel = UILabel().then {
        $0.text = "3.1416346535..."
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
    init(){
        super.init(frame: .zero)
        
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
