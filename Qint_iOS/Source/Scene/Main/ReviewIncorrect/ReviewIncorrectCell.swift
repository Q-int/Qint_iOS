import UIKit
import SnapKit
import Then

class ReviewIncorrectCell: UICollectionViewCell {
    
    var nextButtonTap: ((Int) -> Void)?
    var mainButtonTap: ((Bool) -> Void)?
    
    var index: Int = 0
    var main: Bool = false
    
    private let questionView = UIView().then {
        $0.backgroundColor = UIColor(named: "Mint100")
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = false
        $0.layer.shadowOffset = CGSizeMake(0.4, 0.4)
        $0.layer.shadowOpacity = 0.2
    }
    
    private let questionLabel = UILabel().then {
        $0.text = "π를 제대로 기술한 것은?"
        $0.font = UIFont.systemFont(ofSize: 25)
        $0.numberOfLines = 0
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.7
    }
    
    private let correctButton = UIButton().then {
        $0.answerButton()
        $0.layer.borderColor = UIColor(named: "Green100")?.cgColor
        $0.layer.borderWidth = 3
    }
    
    private let correctLabel = UILabel().then {
        $0.answerLabel()
    }
    
    private let wrongButton = UIButton().then {
        $0.answerButton()
        $0.layer.borderColor = UIColor(named: "Red100")?.cgColor
        $0.layer.borderWidth = 3
    }
    
    private let wrongLabel = UILabel().then {
        $0.answerLabel()
    }
    
    private let solutionView = UIView().then {
        $0.backgroundColor = UIColor(named: "Mint100")
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = false
    }
    
    private let solutionLabel = UILabel().then {
        $0.answerLabel()
        $0.textAlignment = .left
        $0.text = "어쩌구 저쩌구 해서 쨌든 그냥 니가 틀리고 내가 맞음 어쩔팁이"
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    
    private let mainButton = UIButton().then {
        $0.iconButton()
    }
    
    private let nextButton = UIButton().then {
        $0.nextButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        add()
        layout()
    }
    private func attribute() {
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        mainButton.addTarget(self, action: #selector(mainButtonClicked), for: .touchUpInside)
    }
    private func add() {
        [
            questionView,
            correctButton,
            wrongButton,
            solutionView,
            mainButton,
            nextButton
        ].forEach{ contentView.addSubview($0) }
        questionView.addSubview(questionLabel)
        correctButton.addSubview(correctLabel)
        wrongButton.addSubview(wrongLabel)
        solutionView.addSubview(solutionLabel)
    }
    private func layout() {
        questionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(85)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(230)
        }
        questionLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        correctButton.snp.makeConstraints {
            $0.top.equalTo(questionView.snp.bottom).offset(11)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(75)
        }
        correctLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
        wrongButton.snp.makeConstraints {
            $0.top.equalTo(correctButton.snp.bottom).offset(11)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(75)
        }
        wrongLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
        solutionView.snp.makeConstraints {
            $0.top.equalTo(wrongButton.snp.bottom).offset(11)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(220)
        }
        solutionLabel.snp.makeConstraints {
            $0.top.right.left.equalToSuperview().inset(15)
        }
        mainButton.snp.makeConstraints {
            $0.top.equalTo(solutionView.snp.bottom).offset(23)
            $0.left.equalToSuperview().inset(24)
            $0.height.width.equalTo(30)
        }
        nextButton.snp.makeConstraints {
            $0.top.equalTo(solutionView.snp.bottom).offset(18)
            $0.right.equalToSuperview().inset(24)
            $0.height.equalTo(44)
            $0.width.equalTo(105)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with index: Int) {
        self.index = index
    }
    
    @objc func nextButtonClicked() {
        self.nextButtonTap?(index)
    }
    
    @objc func mainButtonClicked() {
        main = true
        self.mainButtonTap?(main)
    }
}
