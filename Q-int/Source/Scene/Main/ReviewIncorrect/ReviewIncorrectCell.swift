import UIKit
import SnapKit
import Then

class ReviewIncorrectCell: UICollectionViewCell {
    
    static let identifier: String = "ReviewIncorrectCell"

    private let questionView = UIView().then {
        $0.questionView()
    }
    
    public let questionLabel = UILabel().then {
        $0.questionLabel()
    }
    
    public let correctButton = AnswerButton(type: .correct)
    public let incorrectButton = AnswerButton(type: .wrong)
    
    private let solutionView = UIView().then {
        $0.backgroundColor = UIColor.mint100
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = false
    }
    
    public let solutionLabel = UILabel().then {
        $0.solutionLabel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        add()
        layout()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func add() {
        [
            questionView,
            correctButton,
            incorrectButton,
            solutionView
        ].forEach{ contentView.addSubview($0) }
        questionView.addSubview(questionLabel)
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
        correctButton.snp.makeConstraints {
            $0.top.equalTo(questionView.snp.bottom).offset(11)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(75)
        }
        incorrectButton.snp.makeConstraints {
            $0.top.equalTo(correctButton.snp.bottom).offset(11)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(75)
        }
        solutionView.snp.makeConstraints {
            $0.top.equalTo(incorrectButton.snp.bottom).offset(11)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(220)
        }
        solutionLabel.snp.makeConstraints {
            $0.top.right.left.equalToSuperview().inset(15)
        }
    }
}
