import UIKit
import SnapKit
import Then

protocol PopupDelegate: AnyObject {
    func navigateToMainView()
    func navigateToMyView()
}

class PopupView: UIView {
    
    weak var delegate: PopupDelegate?
    
    public var correct = 0
    private var wrong: Int {
        return 15 - correct 
    }
    
    private let totalLabel = UILabel()
    private let correctLabel = UILabel()
    private let wrongLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(correctAnswers: Int) {
        self.correct = correctAnswers
        setup()
    }
    
    private func setup() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        
        totalLabel.text = "총 문제 수 : 15"
        totalLabel.font = .systemFont(ofSize: 20)
        
        correctLabel.text = "정답 : \(correct)"
        correctLabel.font = .systemFont(ofSize: 20)
        
        wrongLabel.text = "오답 : \(wrong)"
        wrongLabel.font = .systemFont(ofSize: 20)
        
        let mainButton = UIButton().then {
            $0.setTitle("메인 페이지로 이동", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = UIColor.mint300
            $0.layer.cornerRadius = 8
            $0.addTarget(self, action: #selector(mainButtonTapped), for: .touchUpInside)
        }
        
        let myButton = UIButton().then {
            $0.setTitle("마이 페이지로 이동", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = UIColor.blue100
            $0.layer.cornerRadius = 8
            $0.addTarget(self, action: #selector(myButtonTapped), for: .touchUpInside)
        }
        
        [totalLabel, correctLabel, wrongLabel, mainButton, myButton].forEach { self.addSubview($0) }
        
        totalLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(24)
        }
        correctLabel.snp.makeConstraints {
            $0.top.equalTo(totalLabel.snp.bottom).offset(17)
            $0.left.equalToSuperview().inset(24)
        }
        wrongLabel.snp.makeConstraints {
            $0.top.equalTo(correctLabel.snp.bottom).offset(17)
            $0.left.equalToSuperview().inset(24)
        }
        mainButton.snp.makeConstraints {
            $0.top.equalTo(wrongLabel.snp.bottom).offset(32)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(45)
        }
        myButton.snp.makeConstraints {
            $0.top.equalTo(mainButton.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(45)
        }
    }
    
    @objc private func mainButtonTapped() {
        delegate?.navigateToMainView()
        dismiss()
    }
    
    @objc private func myButtonTapped() {
        delegate?.navigateToMyView()
        dismiss()
    }
    
    private func dismiss() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
}
