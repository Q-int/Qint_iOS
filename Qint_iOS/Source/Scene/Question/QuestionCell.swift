import UIKit

import SnapKit
import Then

class QuestionCell: UICollectionViewCell {
    
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
    
    let questionLabel = UILabel().then {
        $0.text = "π를 제대로 기술한 것은?π를 제대로 기술한 것은?π를 제대로 기술한 것은?π를 제대로 기술한 것은?π를 제대로 기술한 것은?π를 제대로 기술한 것은?π를 제대로 기술한 것은?π를 제대로 기술한 것은?π를 제대로 기술한 것은?π를 제대로 기술한 것은?π를 제대로 기술한 것은?π를 제대로 기술한 것은?"
        $0.font = UIFont.systemFont(ofSize: 25)
        $0.numberOfLines = 0
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.7
    }
    
    let indexLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = UIColor(named: "Gray400")
    }
    
    let answerView = AnswerButtonView()
    
    let mainButton = UIButton().then {
        $0.setImage(UIImage(named: "Home2"), for: .normal)
        $0.tintColor = UIColor(named: "Gray400")
        $0.imageView?.contentMode = .scaleAspectFill
        $0.contentHorizontalAlignment = .fill
        $0.contentVerticalAlignment = .fill
        $0.addTarget(self, action: #selector(mainButtonTapped), for: .touchUpInside)
    }
    
    @objc func mainButtonTapped() {
        main = true
        print("홈 버튼 누름")
    }
    
    let nextButton = UIButton().then {
        $0.setTitle("다음 문제", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20)
        $0.setTitleColor(.white , for: .normal)
        $0.backgroundColor = UIColor(named: "Blue100")
        $0.layer.cornerRadius = 10
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
    }
    
    func add() {
        [
            questionView,
            indexLabel,
            answerView,
            mainButton,
            nextButton
        ].forEach{ contentView.addSubview($0) }
        questionView.addSubview(questionLabel)
    }
    func layout() {
        questionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(91)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(200)
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
            $0.left.right.equalToSuperview().inset(20)
        }
        mainButton.snp.makeConstraints {
            $0.top.equalTo(answerView.snp.bottom).offset(65)
            $0.left.equalToSuperview().inset(24)
            $0.height.width.equalTo(30)
        }
        nextButton.snp.makeConstraints {
            $0.top.equalTo(answerView.snp.bottom).offset(55)
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
}
