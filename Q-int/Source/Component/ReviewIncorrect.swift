import UIKit
import SnapKit
import Then

class reviewIncorrect: UIView {
        
    let label = UILabel().then {
        $0.text = "틀린 문제 다시보기"
        $0.font = .boldSystemFont(ofSize: 25)
        $0.textColor = UIColor.gray400
    }
    
    let image = UIImageView().then {
        $0.image = UIImage.return1
        $0.tintColor = UIColor.gray400
    }
    
    init() {
        super.init(frame: .zero)
        
        add()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func add() {
        [
            label,
            image
        ].forEach{ self.addSubview($0) }
    }
    
    private func layout() {
        label.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview()
        }
        image.snp.makeConstraints {
            $0.top.equalTo(label.snp.top).inset(0)
            $0.bottom.equalTo(label.snp.bottom).inset(2)
            $0.left.equalTo(label.snp.right).inset(3)
            $0.right.equalToSuperview().inset(0)
            $0.height.width.equalTo(40)
        }
        
    }
}
