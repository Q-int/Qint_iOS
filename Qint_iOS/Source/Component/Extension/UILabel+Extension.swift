import UIKit

extension UILabel {
    func questionLabel() {
        self.text = "π를 제대로 기술한 것은?"
        self.font = UIFont.systemFont(ofSize: 25)
        self.textAlignment = .center
        self.numberOfLines = 0
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.7
    }
    
    func answerLabel() {
        self.text = "3.1416346535..."
        self.font = UIFont.systemFont(ofSize: 25)
        self.textAlignment = .center
        self.numberOfLines = 0
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.1
    }
}
