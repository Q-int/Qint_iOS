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
    func solutionLabel() {
        self.numberOfLines = 0
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.1
        self.text = "어쩌구 저쩌구 해서 쨌든 그냥 니가 틀리고 내가 맞음 어쩔팁이"
        self.font = UIFont.systemFont(ofSize: 18)
        self.textAlignment = .left
    }
}
