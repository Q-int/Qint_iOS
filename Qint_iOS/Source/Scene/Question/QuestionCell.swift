import UIKit
import SnapKit
import Then

class QuestionCell: UICollectionViewCell {
    
    static let identifier = "QuestionCell"
    
    private var index: Int = 0
    private var buttonSelect = [UIButton]()
    
    private let questionView = UIView().then {
        $0.questionView()
    }
    
    private let questionLabel = UILabel().then {
        $0.questionLabel()
    }
    
    private let indexLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = UIColor(named: "Gray400")
    }
    
    private let button1 = AnswerButton()
    private let button2 = AnswerButton()
    private let button3 = AnswerButton()
    private let button4 = AnswerButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        add()
        layout()
    }

    private func attribute() {
        [
            button1.answerButton,
            button2.answerButton,
            button3.answerButton,
            button4.answerButton
        ].forEach{ button in
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
        [
            button1.answerButton,
            button2.answerButton,
            button3.answerButton,
            button4.answerButton
        ].forEach{ buttonSelect.append($0) }
    }
    
    private func add() {
        [
            questionView,
            indexLabel,
            button1,
            button2,
            button3,
            button4,
        ].forEach{ contentView.addSubview($0) }
        questionView.addSubview(questionLabel)
    }
    
    private func layout() {
        questionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(74)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(215)
        }
        questionLabel.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview().inset(15)
        }
        indexLabel.snp.makeConstraints {
            $0.top.equalTo(questionView.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        button1.snp.makeConstraints {
            $0.top.equalTo(indexLabel.snp.bottom).offset(30)
            $0.height.equalTo(75)
            $0.left.right.equalToSuperview().inset(20)
        }
        button2.snp.makeConstraints {
            $0.top.equalTo(button1.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(75)
        }
        button3.snp.makeConstraints {
            $0.top.equalTo(button2.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(75)
        }
        button4.snp.makeConstraints {
            $0.top.equalTo(button3.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(75)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(index: Int) {
        indexLabel.text = "\(index+1)/15"
        self.index = index
    }
    @objc private func buttonTapped(_ sender: UIButton) {
        for i in buttonSelect {
            i.backgroundColor = i == sender ? UIColor(named: "Mint200") : UIColor(named: "Mint100")
        }
    }
}
