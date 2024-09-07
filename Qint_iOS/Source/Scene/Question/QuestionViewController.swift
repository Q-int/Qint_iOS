import UIKit
import SnapKit
import Then

class QuestionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PopupDelegate {
    
    private var collectionView: UICollectionView!
    private var darkBackground: UIView?
    var cellIndex: Int = 0
    var solIndex: Int = 0
    
    
    private let mainButton = UIButton().then {
        $0.iconButton()
    }
    
    private let solutionButton = UIButton().then {
        $0.setTitle("해설", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20)
        $0.backgroundColor = UIColor(named: "Mint300")
        $0.layer.cornerRadius = 10
    }
    
    private let nextButton = UIButton().then {
        $0.nextButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(cellIndex)
        
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
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.register(QuestionCell.self, forCellWithReuseIdentifier: QuestionCell.identifier)
        
        
        mainButton.addTarget(self, action: #selector(mainButtonTap), for: .touchUpInside)
        solutionButton.addTarget(self, action: #selector(solutionButtonTap), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    private func add() {
        [
            collectionView,
            mainButton,
            solutionButton,
            nextButton
        ].forEach{ view.addSubview($0) }
    }
    
    private func layout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        mainButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(74)
            $0.left.equalToSuperview().inset(24)
            $0.height.width.equalTo(30)
        }
        solutionButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(64)
            $0.right.equalTo(nextButton.snp.left).offset(-12)
            $0.height.equalTo(45)
            $0.width.equalTo(67)
        }
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(64)
            $0.right.equalToSuperview().inset(24)
            $0.height.equalTo(45)
            $0.width.equalTo(105)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  QuestionCell.identifier, for: indexPath) as? QuestionCell
        
        cell?.configure(with:  solIndex + 1)
        self.solIndex = solIndex + 1
        self.cellIndex += 1
        print("cellIndex : \(self.solIndex)")
        
        return cell ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    @objc private func mainButtonTap() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func solutionButtonTap() {
        let vc = SolutionViewController()
        vc.solutionIndex = self.cellIndex
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func nextButtonTapped() {
        if (solIndex >= 15) {
            self.buttonTapped()
        } else {
            print("index: \(cellIndex)")
            DispatchQueue.main.async {
                self.collectionView.isPagingEnabled = false
                self.collectionView.scrollToItem(at: IndexPath(row: self.cellIndex, section: 0), at: .left, animated: true)
                self.collectionView.isPagingEnabled = true
            }
        }
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
