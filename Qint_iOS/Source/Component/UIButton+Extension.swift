import UIKit

extension UIButton {
    func QintButton(setTitle: String, setTitleColor: String, buttonColor: String) {
        self.setTitle(setTitle, for: .normal)
        self.setTitleColor(UIColor(named: setTitleColor), for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        self.backgroundColor = UIColor(named: buttonColor)
        self.layer.cornerRadius = 8
    }
    
    func answerButton() {
        self.backgroundColor = UIColor(named: "Mint100")
        self.layer.cornerRadius = 10
    }
}
