import UIKit
import SnapKit
import Then

class QuestionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionView :UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
