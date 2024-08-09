import UIKit
import SnapKit
import Then

class QuestionCell: UICollectionViewCell {
    
    let questionView = UIView().then {
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
        
    }
    func add() {
        [
            questionView,
            indexLabel,
            nextButton
        ].forEach{ contentView.addSubview($0) }
        questionView.addSubview(questionLabel)
    }
    func layout() {
        questionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(70)
            $0.left.right.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(564)
        }
        questionLabel.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview().inset(15)
        }
        indexLabel.snp.makeConstraints {
            $0.top.equalTo(questionView.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(93)
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
    }
}
