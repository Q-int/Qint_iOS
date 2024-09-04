import UIKit
import SnapKit
import Then

class QuestionCell: UICollectionViewCell {
    
    var nextButtonTap: ((Int) -> Void)?
    var mainButtonTap: ((Bool) -> Void)?
    var solutionButtonTap: ((Bool) -> Void)?
    
    var index: Int = 0
    private var main: Bool = false
    private var soluton: Bool = false
    private var buttonSelect = [UIButton]()
    
    private let questionView = UIView().then {
        $0.questionView()
    }
    
    private let questionLabel = UILabel().then {
        $0.questionLabel()
    }
    
    let indexLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = UIColor(named: "Gray400")
    }
    
    private let button1 = UIButton().then {
        $0.answerButton()
    }
    
    private let label1 = UILabel().then {
        $0.answerLabel()
    }
    private let button2 = UIButton().then {
        $0.answerButton()
    }
    
    private let label2 = UILabel().then {
        $0.answerLabel()
    }
    private let button3 = UIButton().then {
        $0.answerButton()
    }
    
    private let label3 = UILabel().then {
        $0.answerLabel()
    }
    private let button4 = UIButton().then {
        $0.answerButton()
    }
    
    private let label4 = UILabel().then {
        $0.answerLabel()
    }
    
//    private let mainButton = UIButton().then {
//        $0.iconButton()
//    }
//    
//    private let solutionButton = UIButton().then {
//        $0.setTitle("해설", for: .normal)
//        $0.setTitleColor(.white, for: .normal)
//        $0.titleLabel?.font = .systemFont(ofSize: 20)
//        $0.backgroundColor = UIColor(named: "Mint300")
//        $0.layer.cornerRadius = 10
//    }
//    
//    private let nextButton = UIButton().then {
//        $0.nextButton()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        add()
        layout()
    }

    private func attribute() {
//        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
//        mainButton.addTarget(self, action: #selector(mainButtonTapped), for: .touchUpInside)
//        mainButton.addTarget(self, action: #selector(mainButtonClicked), for: .touchUpInside)
//        solutionButton.addTarget(self, action: #selector(solutionButtonTapped), for: .touchUpInside)
//        solutionButton.addTarget(self, action: #selector(solutionButtonClicked), for: .touchUpInside)
        [
            button1,
            button2,
            button3,
            button4
        ].forEach{ button in
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
    }
    
    private func add() {
        [
            button1,
            button2,
            button3,
            button4
        ].forEach{buttonSelect.append($0)}
        
        [
            questionView,
            indexLabel,
            button1,
            button2,
            button3,
            button4,
//            mainButton,
//            solutionButton,
//            nextButton
        ].forEach{ contentView.addSubview($0) }
        questionView.addSubview(questionLabel)
        button1.addSubview(label1)
        button2.addSubview(label2)
        button3.addSubview(label3)
        button4.addSubview(label4)
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
        label1.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview().inset(12)
        }
        button2.snp.makeConstraints {
            $0.top.equalTo(button1.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(75)
        }
        label2.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview().inset(12)
        }
        button3.snp.makeConstraints {
            $0.top.equalTo(button2.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(75)
        }
        label3.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview().inset(12)
        }
        button4.snp.makeConstraints {
            $0.top.equalTo(button3.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(75)
        }
        label4.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview().inset(12)
        }
//        mainButton.snp.makeConstraints {
//            $0.top.equalTo(button4.snp.bottom).offset(49)
//            $0.left.equalToSuperview().inset(24)
//            $0.height.width.equalTo(30)
//        }
//        solutionButton.snp.makeConstraints {
//            $0.top.equalTo(button4.snp.bottom).offset(44)
//            $0.right.equalTo(nextButton.snp.left).offset(-12)
//            $0.height.equalTo(45)
//            $0.width.equalTo(67)
//        }
//        nextButton.snp.makeConstraints {
//            $0.top.equalTo(button4.snp.bottom).offset(44)
//            $0.right.equalToSuperview().inset(24)
//            $0.height.equalTo(45)
//            $0.width.equalTo(105)
//        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with index: Int) {
        indexLabel.text = "\(index)/15"
        self.index = index
    }
    
    @objc private func nextButtonClicked() {
        print("cellIndex: \(index)")
        self.nextButtonTap?(index)
    }
    
    @objc private func mainButtonClicked() {
        self.mainButtonTap?(main)
    }
    
    @objc private  func solutionButtonClicked() {
        self.solutionButtonTap?(soluton)
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        for i in buttonSelect {
            i.backgroundColor = i == sender ? UIColor(named: "Mint200") : UIColor(named: "Mint100")
        }
    }
    @objc private func mainButtonTapped() {
        main = true
        print("홈 버튼 누름")
    }
    @objc private func solutionButtonTapped() {
        soluton = true
    }
}
