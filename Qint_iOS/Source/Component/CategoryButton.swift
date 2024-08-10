import UIKit
import SnapKit
import Then

enum BtType {
    case fe
    case be
    case ios
    case flutter
    case custom(title: String, image: String, left: Int, right: Int)
    
    var text: String {
        switch self {
        case .fe:
            return "프론트엔드"
        case .be:
            return "백엔드"
        case .ios:
            return "iOS"
        case .flutter:
            return "플러터"
        case .custom(let title, _, _, _):
            return title
        }
    }
    var image: String {
        switch self {
        case .fe:
            return "feImage"
        case .be:
            return "beImage"
        case .ios:
            return "iosImage"
        case .flutter:
            return "flutterImage"
        case .custom(_, let image, _, _):
            return image
        }
    }
    var left: Int {
        switch self {
        case .fe:
            return 205
        case .be:
            return 0
        case .ios:
            return 205
        case .flutter:
            return 0
        case .custom(_, _, let left, _):
            return left
        }
    }
    var right: Int {
        switch self {
        case .fe:
            return 0
        case .be:
            return 205
        case .ios:
            return 0
        case .flutter:
            return 205
        case .custom(_, _, _, let right):
            return right
        }
    }
}

class CategoryButton: UIView {
    let button = UIButton().then {
        $0.backgroundColor = UIColor(named: "Mint100")
        $0.layer.cornerRadius = 10
        $0.adjustsImageWhenHighlighted = false
    }
    
    let label = UILabel().then {
        $0.textColor = UIColor(named: "Mint300")
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    init(type: BtType) {
        super.init(frame: .zero)
        
        button.setImage(UIImage(named: type.image), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: CGFloat(type.left), bottom: 0, right: CGFloat(type.right))
        label.text = type.text
        
        add()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func add() {
        self.addSubview(button)
        button.addSubview(label)
    }
    
    func layout() {
        button.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        label.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
