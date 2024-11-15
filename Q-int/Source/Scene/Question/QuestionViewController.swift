import UIKit
import SnapKit
import Then

class QuestionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PopupDelegate {
    
    private var darkBackground: UIView?
    public var solIndex: Int = 0
    public var questionsArray = [Question]()
    private var answerId = 0
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 0
    }).then {
        $0.dataSource = self
        $0.delegate = self
        $0.register(QuestionCell.self, forCellWithReuseIdentifier: QuestionCell.identifier)
        $0.isPagingEnabled = true
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = false
    }
    
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
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        add()
        layout()
    }
    
    private func attribute() {
        view.backgroundColor = .white
        
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
    
    @objc private func mainButtonTap() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func solutionButtonTap() {
        let vc = SolutionViewController()
        vc.solutionIndex = solIndex
        vc.questionId = questionsArray[solIndex].question_id
        vc.answerId = answerId
        vc.questionLabel.text = questionsArray[solIndex].contents
        self.present(vc, animated: true)
    }
    
    @objc private func nextButtonTapped() {
        if solIndex < 14 {
            solIndex += 1
            print(solIndex)
            collectionView.isPagingEnabled = false
            self.collectionView.scrollToItem(at: IndexPath(row: solIndex, section: 0), at: .left, animated: true)
        } else {
            buttonTapped()
        }
    }
    private func buttonTapped() {
        showPopup()
    }
    private func showPopup() {
        if darkBackground != nil { return }
        
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

extension QuestionViewController {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuestionCell.identifier, for: indexPath) as? QuestionCell
        cell?.configure(index: indexPath.row)
        let question = questionsArray[indexPath.row]
        cell?.question = question
        cell?.questionLabel.text = question.contents
        cell?.button1.answerLabel.text = question.options[0].text
        cell?.button2.answerLabel.text = question.options[1].text
        cell?.button3.answerLabel.text = question.options[2].text
        cell?.button4.answerLabel.text = question.options[3].text
        for i in 0..<4 {
            if cell?.buttonSelect[i].layer.borderColor == UIColor.green100.cgColor {
                answerId = question.options[i].answer_id
            }
        }
        for i in 0..<4 {
            cell?.buttonSelect[i].backgroundColor = UIColor(named: "Mint100")
            cell?.buttonSelect[i].layer.cornerRadius = 10
            cell?.buttonSelect[i].layer.borderWidth = 0
            cell?.buttonSelect[i].isEnabled = true
        }
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
