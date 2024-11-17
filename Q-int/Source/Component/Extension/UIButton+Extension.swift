import UIKit

extension UIButton {
    func qintButton(setTitle: String, setTitleColor: String, buttonColor: String) {
        self.setTitle(setTitle, for: .normal)
        self.setTitleColor(UIColor(named: setTitleColor), for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        self.backgroundColor = UIColor(named: buttonColor)
        self.layer.cornerRadius = 8
    }
    
    func nextButton() {
        self.setTitle("다음 문제", for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 20)
        self.setTitleColor(.white , for: .normal)
        self.backgroundColor = UIColor.blue100
        self.layer.cornerRadius = 10
    }
    
    func iconButton() {
        self.setImage(UIImage(named: "Home2"), for: .normal)
        self.tintColor = UIColor.gray400
        self.imageView?.contentMode = .scaleAspectFill
        self.contentHorizontalAlignment = .fill
        self.contentVerticalAlignment = .fill
    }
}
