import UIKit

extension UIButton {
    func QintButton(setTitle: String, setTitleColor: String, buttonColor: String) {
        self.setTitle(setTitle, for: .normal)
        self.setTitleColor(UIColor(named: setTitleColor), for: .normal)
        self.backgroundColor = UIColor(named: buttonColor)
        self.layer.cornerRadius = 8
    }
}
