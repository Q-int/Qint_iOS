import UIKit
import SnapKit
import Then

class foodButton: UIButton {
    
    public init(color: UIColor) {
        super.init(frame: .zero)
        
        self.backgroundColor = color
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .red
        self.setTitle("food", for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct Component {
    static func foodButtonComponent(color: UIColor) -> UIButton {
        UIButton().then {
            $0.backgroundColor = color
        }
    }
}

class testViewController: UIViewController {
    
    var a = foodButton(color: .red)
    
    var b = Component.foodButtonComponent(color: .red)
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}


class AnswerButtonView: UIView {
    
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
        self.addSubview(button1)
        button1.addSubview(label1)
        self.addSubview(button2)
        button2.addSubview(label2)
        self.addSubview(button3)
        button3.addSubview(label3)
        self.addSubview(button4)
        button4.addSubview(label4)
    }
    
    func layout() {
        button1.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(75)
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
}
