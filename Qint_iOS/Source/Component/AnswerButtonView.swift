import UIKit
import SnapKit
import Then

class AnswerButtonView: UIView {
    
    var buttonSelect = [UIButton]()
    
    let button1 = UIButton().then {
        $0.answerButton()
    }
    
    let label1 = UILabel().then {
        $0.answerLabel()
    }
    let button2 = UIButton().then {
        $0.answerButton()
    }
    
    let label2 = UILabel().then {
        $0.answerLabel()
    }
    let button3 = UIButton().then {
        $0.answerButton()
    }
    
    let label3 = UILabel().then {
        $0.answerLabel()
    }
    let button4 = UIButton().then {
        $0.answerButton()
    }
    
    let label4 = UILabel().then {
        $0.answerLabel()
    }
    
    init() {
        super.init(frame: .zero)
        
        attribute()
        add()
        layout()
    }
    
    func attribute() {
        [
            button1,
            button2,
            button3,
            button4
        ].forEach{ button in
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
    }
    
    func add() {
        [
            button1,
            button2,
            button3,
            button4
        ].forEach{buttonSelect.append($0)}
        
        [
            button1,
            button2,
            button3,
            button4
        ].forEach{ self.addSubview($0) }
        button1.addSubview(label1)
        button2.addSubview(label2)
        button3.addSubview(label3)
        button4.addSubview(label4)
    }
    
    func layout() {
        button1.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(75)
            $0.left.right.equalToSuperview()
        }
        label1.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview().inset(12)
        }
        button2.snp.makeConstraints {
            $0.top.equalTo(button1.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(75)
        }
        label2.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview().inset(12)
        }
        button3.snp.makeConstraints {
            $0.top.equalTo(button2.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(75)
        }
        label3.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview().inset(12)
        }
        button4.snp.makeConstraints {
            $0.top.equalTo(button3.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(75)
        }
        label4.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview().inset(12)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        print("\(sender)버튼 클릭됨")
        for i in buttonSelect {
            if i == sender {
                i.backgroundColor = UIColor(named: "Mint200")
            } else {
                i.backgroundColor = UIColor(named: "Mint100")
            }
        }
    }
}
