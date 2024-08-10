import UIKit
import SnapKit
import Then


class AnswerButtonView: UIView {
    let backView = UIView().then {
        $0.backgroundColor = .clear
    }
    
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
        
        add()
        layout()
    }
    
    func add() {
        self.addSubview(backView)
        backView.addSubview(button1)
        button1.addSubview(label1)
        backView.addSubview(button2)
        button2.addSubview(label2)
        backView.addSubview(button3)
        button3.addSubview(label3)
        backView.addSubview(button4)
        button4.addSubview(label4)
    }
    
    func layout() {
        backView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalTo(button4.snp.bottom)
            $0.bottom.left.right.equalToSuperview()
        }
        button1.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        label1.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(20)
            $0.left.right.equalToSuperview().inset(20)
        }
        button2.snp.makeConstraints {
            $0.top.equalTo(button1.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
        }
        label2.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(20)
            $0.left.right.equalToSuperview().inset(20)
        }
        button3.snp.makeConstraints {
            $0.top.equalTo(button2.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
        }
        label3.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(20)
            $0.left.right.equalToSuperview().inset(20)
        }
        button4.snp.makeConstraints {
            $0.top.equalTo(button3.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
        }
        label4.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(20)
            $0.left.right.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
