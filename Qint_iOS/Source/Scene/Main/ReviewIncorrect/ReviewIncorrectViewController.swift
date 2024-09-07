import UIKit
import SnapKit
import Then

class ReviewIncorrectViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var collectionView :UICollectionView!
    
    private var viewIndex: Int = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        add()
        layout()
    }
    
    private func attribute() {
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ReviewIncorrectCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        
        
    }
    private func add() {
        view.addSubview(collectionView)
    }
    private func layout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ReviewIncorrectCell
        
        cell?.configure(with: indexPath.item + 1)
        
        cell?.nextButtonTap = { index in
            print("현재 인덱스 : \(index)")
            if(index == self.viewIndex) {
                print("마지막!")
            } else {
                self.collectionView.isPagingEnabled = false
                self.collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .left, animated: true)
                self.collectionView.isPagingEnabled = true
            }
        }
        
        cell?.mainButtonTap = { main in
            if(main == true) {
                self.navigationController?.popViewController(animated: true)
            }
        }
        return cell ?? ReviewIncorrectCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewIndex
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}
