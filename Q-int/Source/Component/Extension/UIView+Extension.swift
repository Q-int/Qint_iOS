import UIKit

extension UIView {
    func questionView() {
        self.backgroundColor = UIColor.mint100
        self.layer.cornerRadius = 20
        self.clipsToBounds = false
        self.layer.shadowOffset = CGSizeMake(0.4, 0.4)
        self.layer.shadowOpacity = 0.2
    }
}
