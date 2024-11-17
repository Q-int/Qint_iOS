import UIKit

extension UILabel {
    func questionLabel() {
        self.font = UIFont.systemFont(ofSize: 25)
        self.textAlignment = .center
        self.numberOfLines = 0
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.7
    }
    func solutionLabel() {
        self.numberOfLines = 0
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.1
        self.font = UIFont.systemFont(ofSize: 18)
        self.textAlignment = .left
    }
}
