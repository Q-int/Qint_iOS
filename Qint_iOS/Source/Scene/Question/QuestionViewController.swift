import UIKit
import SnapKit
import Then

class QuestionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PopupDelegate {
    
    var collectionView: UICollectionView!
    var darkBackground: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        attribute()
        add()
        layout()
    }
    
    func attribute() {
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(QuestionCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
    }
    
    func add() {
        view.addSubview(collectionView)
    }
    
    func layout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? QuestionCell
        
        cell?.configure(with: indexPath.item + 1)
        
        cell?.nextButtonTap = { index in
            if (index == 15) {
                self.buttonTapped()
            } else {
                self.collectionView.isPagingEnabled = false
                self.collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .left, animated: true)
                self.collectionView.isPagingEnabled = true
            }
        }
        
        cell?.mainButtonTap = { main in
            if (main == true) {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        cell?.solutionButtonTap = { solution in
            if (solution == true) {
                let next = SolutionViewController()
                next.modalPresentationStyle = .fullScreen
                
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = .fade
                transition.subtype = .fromTop
                collectionView.window?.layer.add(transition, forKey: kCATransition)
                
                self.present(next, animated: true, completion: nil)
            }
        }
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func buttonTapped() {
        showPopup()
    }
    
    private func showPopup() {
        let dark = UIView(frame: self.view.bounds)
        dark.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.view.addSubview(dark)
        self.darkBackground = dark
        
        let popup = PopupView().then {
            $0.delegate = self
            self.view.addSubview($0)
        }
        
        popup.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(270)
            $0.height.equalTo(297)
        }
    }
    
    func navigateToMainView() {
        dismissPopup()
        navigationController?.pushViewController(MainViewController(), animated: true)
    }
    
    func navigateToMyView() {
        dismissPopup()
        navigationController?.pushViewController(MyViewController(), animated: true)
    }
    
    private func dismissPopup() {
        darkBackground?.removeFromSuperview()
    }
}
