import UIKit

extension UILabel {
    func answerLabel() {
        self.text = "3.1416346535..."
        self.font = UIFont.systemFont(ofSize: 20)
        self.numberOfLines = 0
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.1
    }
}
