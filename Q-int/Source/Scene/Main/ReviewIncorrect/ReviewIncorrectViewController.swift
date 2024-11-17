import UIKit
import SnapKit
import Then

class ReviewIncorrectViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var viewIndex: Int = 15
    private var cellIndex: Int = 0
    public var questionArray = [Answers]()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 0
    }).then {
        $0.dataSource = self
        $0.delegate = self
        $0.register(ReviewIncorrectCell.self, forCellWithReuseIdentifier: ReviewIncorrectCell.identifier)
        $0.isPagingEnabled = true
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = false
    }
    private let nextButton = UIButton().then {
        $0.nextButton()
    }
    private let myButton = UIButton().then {
        $0.iconButton()
        $0.setImage(UIImage(systemName: "person.fill"), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        add()
        layout()
    }
    
    private func attribute() {
        view.backgroundColor = .white
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        myButton.addTarget(self, action: #selector(myButtonTapped), for: .touchUpInside)
    }
    private func add() {
        [
            collectionView,
            nextButton,
            myButton
        ].forEach{ view.addSubview($0) }
    }
    private func layout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        nextButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(44)
            $0.width.equalTo(105)
        }
        myButton.snp.makeConstraints {
            $0.left.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(23)
            $0.height.width.equalTo(30)
        }
    }
    
    @objc private func nextButtonTapped() {
        let indexPath = IndexPath(item: cellIndex, section: 0)
        
        if cellIndex < questionArray.count {
            cellIndex += 1
            collectionView.isPagingEnabled = false
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        } else {
            showAlert()
        }
    }
    @objc private func myButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    private func showAlert() {
        let title = "마이페이지로 이동하시겠습니까?"
        let message = "모든 문제를 확이하셨습니다!"
        let alertStyle: UIAlertController.Style = .alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        let confirmAction = UIAlertAction(title: "이동", style: .destructive) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        present(alert, animated: true)
    }
}
extension ReviewIncorrectViewController {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewIncorrectCell.identifier, for: indexPath) as? ReviewIncorrectCell
        
        let question = questionArray[indexPath.row]
        cell?.questionLabel.text = question.contents
        cell?.correctButton.answerLabel.text = question.correct_answer
        cell?.incorrectButton.answerLabel.text = question.incorrect_answer
        cell?.solutionLabel.text = question.commentary
        
        return cell ?? ReviewIncorrectCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
