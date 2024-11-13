import UIKit
import SnapKit
import Then

class QuestionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PopupDelegate {
    
    private var darkBackground: UIView?
    public var solIndex: Int = 0
    private let questionsArray = [
        Question(
            questionID: 1,
            contents: "1번 문제",
            options: [
                Option(answerID: 1, text: "1번 문제의 1번 답"),
                Option(answerID: 2, text: "1번 문제의 2번 답"),
                Option(answerID: 3, text: "1번 문제의 3번 답"),
                Option(answerID: 4, text: "1번 문제의 4번 답")
            ]
        ),
        Question(
            questionID: 2,
            contents: "2번 문제",
            options: [
                Option(answerID: 1, text: "2번 문제의 1번 답"),
                Option(answerID: 2, text: "2번 문제의 2번 답"),
                Option(answerID: 3, text: "2번 문제의 3번 답"),
                Option(answerID: 4, text: "2번 문제의 4번 답")
            ]
        ),
        Question(
            questionID: 3,
            contents: "3번 문제",
            options: [
                Option(answerID: 1, text: "3번 문제의 1번 답"),
                Option(answerID: 2, text: "3번 문제의 2번 답"),
                Option(answerID: 3, text: "3번 문제의 3번 답"),
                Option(answerID: 4, text: "3번 문제의 4번 답")
            ]
        ),
        Question(
            questionID: 4,
            contents: "4번 문제",
            options: [
                Option(answerID: 1, text: "4번 문제의 1번 답"),
                Option(answerID: 2, text: "4번 문제의 2번 답"),
                Option(answerID: 3, text: "4번 문제의 3번 답"),
                Option(answerID: 4, text: "4번 문제의 4번 답")
            ]
        ),
        Question(
            questionID: 5,
            contents: "5번 문제",
            options: [
                Option(answerID: 1, text: "5번 문제의 1번 답"),
                Option(answerID: 2, text: "5번 문제의 2번 답"),
                Option(answerID: 3, text: "5번 문제의 3번 답"),
                Option(answerID: 4, text: "5번 문제의 4번 답")
            ]
        ),
        Question(
            questionID: 6,
            contents: "6번 문제",
            options: [
                Option(answerID: 1, text: "6번 문제의 1번 답"),
                Option(answerID: 2, text: "6번 문제의 2번 답"),
                Option(answerID: 3, text: "6번 문제의 3번 답"),
                Option(answerID: 4, text: "6번 문제의 4번 답")
            ]
        ),
        Question(
            questionID: 7,
            contents: "7번 문제",
            options: [
                Option(answerID: 1, text: "7번 문제의 1번 답"),
                Option(answerID: 2, text: "7번 문제의 2번 답"),
                Option(answerID: 3, text: "7번 문제의 3번 답"),
                Option(answerID: 4, text: "7번 문제의 4번 답")
            ]
        ),
        Question(
            questionID: 8,
            contents: "8번 문제",
            options: [
                Option(answerID: 1, text: "8번 문제의 1번 답"),
                Option(answerID: 2, text: "8번 문제의 2번 답"),
                Option(answerID: 3, text: "8번 문제의 3번 답"),
                Option(answerID: 4, text: "8번 문제의 4번 답")
            ]
        ),
        Question(
            questionID: 9,
            contents: "9번 문제",
            options: [
                Option(answerID: 1, text: "9번 문제의 1번 답"),
                Option(answerID: 2, text: "9번 문제의 2번 답"),
                Option(answerID: 3, text: "9번 문제의 3번 답"),
                Option(answerID: 4, text: "9번 문제의 4번 답")
            ]
        ),
        Question(
            questionID: 10,
            contents: "10번 문제",
            options: [
                Option(answerID: 1, text: "10번 문제의 1번 답"),
                Option(answerID: 2, text: "10번 문제의 2번 답"),
                Option(answerID: 3, text: "10번 문제의 3번 답"),
                Option(answerID: 4, text: "10번 문제의 4번 답")
            ]
        ),
        Question(
            questionID: 11,
            contents: "11번 문제",
            options: [
                Option(answerID: 1, text: "11번 문제의 1번 답"),
                Option(answerID: 2, text: "11번 문제의 2번 답"),
                Option(answerID: 3, text: "11번 문제의 3번 답"),
                Option(answerID: 4, text: "11번 문제의 4번 답")
            ]
        ),
        Question(
            questionID: 12,
            contents: "12번 문제",
            options: [
                Option(answerID: 1, text: "12번 문제의 1번 답"),
                Option(answerID: 2, text: "12번 문제의 2번 답"),
                Option(answerID: 3, text: "12번 문제의 3번 답"),
                Option(answerID: 4, text: "12번 문제의 4번 답")
            ]
        ),
        Question(
            questionID: 13,
            contents: "13번 문제",
            options: [
                Option(answerID: 1, text: "13번 문제의 1번 답"),
                Option(answerID: 2, text: "13번 문제의 2번 답"),
                Option(answerID: 3, text: "13번 문제의 3번 답"),
                Option(answerID: 4, text: "13번 문제의 4번 답")
            ]
        ),
        Question(
            questionID: 14,
            contents: "14번 문제",
            options: [
                Option(answerID: 1, text: "14번 문제의 1번 답"),
                Option(answerID: 2, text: "14번 문제의 2번 답"),
                Option(answerID: 3, text: "14번 문제의 3번 답"),
                Option(answerID: 4, text: "14번 문제의 4번 답")
            ]
        ),
        Question(
            questionID: 15,
            contents: "15번 문제",
            options: [
                Option(answerID: 1, text: "15번 문제의 1번 답"),
                Option(answerID: 2, text: "15번 문제의 2번 답"),
                Option(answerID: 3, text: "15번 문제의 3번 답"),
                Option(answerID: 4, text: "15번 문제의 4번 답")
            ]
        )
    ]

    
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
        cell?.questionLabel.text = question.contents
        cell?.button1.answerLabel.text = question.options[0].text
        cell?.button2.answerLabel.text = question.options[1].text
        cell?.button3.answerLabel.text = question.options[2].text
        cell?.button4.answerLabel.text = question.options[3].text
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
