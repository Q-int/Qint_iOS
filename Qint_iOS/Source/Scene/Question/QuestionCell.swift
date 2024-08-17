import UIKit

import SnapKit
import Then

class QuestionCell: UICollectionViewCell {
    
    var nextButtonTap: ((Int) -> Void)?
    var mainButtonTap: ((Bool) -> Void)?
    var solutionButtonTap: ((Bool) -> Void)?
    
    var index: Int = 0
    var main: Bool = false
    var soluton: Bool = false
    
    private let questionView = UIView().then {
        $0.questionView()
    }
    
    let questionLabel = UILabel().then {
        $0.questionLabel()
    }
    
    let indexLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = UIColor(named: "Gray400")
    }
    
    let answerView = AnswerButtonView()
    
    let mainButton = UIButton().then {
        $0.iconButton()
        $0.addTarget(self, action: #selector(mainButtonTapped), for: .touchUpInside)
    }
    
    @objc func mainButtonTapped() {
        main = true
        print("홈 버튼 누름")
    }
    
    let solutionButton = UIButton().then {
        $0.setTitle("해설", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20)
        $0.backgroundColor = UIColor(named: "Mint300")
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(solutionButtonTapped), for: .touchUpInside)
    }
    
    @objc func solutionButtonTapped() {
        soluton = true
    }
    
    let nextButton = UIButton().then {
        $0.nextButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        add()
        layout()
    }

    func attribute() {
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        mainButton.addTarget(self, action: #selector(mainButtonClicked), for: .touchUpInside)
        solutionButton.addTarget(self, action: #selector(solutionButtonClicked), for: .touchUpInside)
    }
    
    func add() {
        [
            questionView,
            indexLabel,
            answerView,
            mainButton,
            solutionButton,
            nextButton
        ].forEach{ contentView.addSubview($0) }
        questionView.addSubview(questionLabel)
    }
    func layout() {
        questionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(85)
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
        answerView.snp.makeConstraints {
            $0.top.equalTo(indexLabel.snp.bottom).offset(30)
            $0.left.right.equalToSuperview().inset(24)
        }
        mainButton.snp.makeConstraints {
            $0.top.equalTo(answerView.button4.snp.bottom).offset(49)
            $0.left.equalToSuperview().inset(24)
            $0.height.width.equalTo(30)
        }
        solutionButton.snp.makeConstraints {
            $0.top.equalTo(answerView.button4.snp.bottom).offset(44)
            $0.right.equalTo(nextButton.snp.left).offset(-12)
            $0.height.equalTo(45)
            $0.width.equalTo(67)
        }
        nextButton.snp.makeConstraints {
            $0.top.equalTo(answerView.button4.snp.bottom).offset(44)
            $0.right.equalToSuperview().inset(24)
            $0.height.equalTo(45)
            $0.width.equalTo(105)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with index: Int) {
        indexLabel.text = "\(index)/15"
        self.index = index
    }
    
    @objc func nextButtonClicked() {
        self.nextButtonTap?(index)
    }
    
    @objc func mainButtonClicked() {
        self.mainButtonTap?(main)
    }
    
    @objc func solutionButtonClicked() {
        self.solutionButtonTap?(soluton)
    }
}
