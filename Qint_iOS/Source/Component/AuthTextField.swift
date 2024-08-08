import UIKit
import SnapKit
import Then

enum TFType {
    case email
    case authentication
    case pwd
    case confirmpwd
    case custom(title: String, placeholder: String)
    var text: String {
        switch self {
        case .email:
            return "이메일"
        case .authentication:
            return "인증코드"
        case .pwd:
            return "비밀번호"
        case .confirmpwd:
            return "비밀번호 재입력"
        case .custom(let title, let placeholder):
            return title + "," + placeholder
        }
    }
}

class AuthTextField: UIView {
    var iconClick = true
    
    let textField = UITextField().then() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: $0.frame.height))
        $0.leftView = paddingView
        $0.leftViewMode = .always
        $0.font = .systemFont(ofSize: 16)
        $0.isSecureTextEntry = false
        $0.backgroundColor = UIColor(named: "Gray100")
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(didSetectTextField), for: .editingDidBegin)
        $0.addTarget(self, action: #selector(didEndSetectTextField), for: .editingDidEnd)
    }
    
    @objc func didSetectTextField() {
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(named: "Gray200")?.cgColor
    }
    
    @objc func didEndSetectTextField() {
        textField.backgroundColor = UIColor(named: "Gray100")
        textField.layer.borderWidth = 0
    }
    
    let showPasswordButton = UIButton().then {
        $0.setImage(UIImage(named: "Eye open"), for: .normal)
        $0.setImage(UIImage(systemName: "Eye off"), for: .selected)
        $0.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: -13, bottom: 0, right: 10)
        $0.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
    }
    
    init(type: TFType) {
        super.init(frame: .zero)
        
        textField.attributedPlaceholder = NSAttributedString(string: type.text, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        switch type {
        case .email:
            break
        case .authentication:
            break
        case .pwd:
            textField.isSecureTextEntry = true
            textField.rightView = showPasswordButton
            textField.rightViewMode = .always
        case .confirmpwd:
            textField.isSecureTextEntry = true
            textField.rightView = showPasswordButton
            textField.rightViewMode = .always
        case .custom:
            let texts = type.text.components(separatedBy: ",")
            textField.attributedPlaceholder = NSAttributedString(string: texts[1], attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        }
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        self.addSubview(textField)
        
        textField.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(0)
            $0.height.equalTo(52)
        }
    }
    
    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        if iconClick {
            textField.isSecureTextEntry = false
            sender.setImage(UIImage(systemName: "Eye off"), for: .normal)
        } else {
            textField.isSecureTextEntry = true
            sender.setImage(UIImage(named: "Eye open"), for: .normal)
        }
        iconClick = !iconClick
    }
    
    
    public func currentText() -> String {
        return textField.text ?? ""
    }
}
