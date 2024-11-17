import UIKit
import SnapKit
import Then
import Moya

class QuestionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PopupDelegate {
    
    private let questionProvider = MoyaProvider<QuestionAPI>()
    private var darkBackground: UIView?
    public var solIndex: Int = 0
    public var questionsArray = [Question]()
    private var answerId = 0
    public var correct = 0
    
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
    
    public let solutionButton = UIButton().then {
        $0.setTitle("해설", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20)
        $0.backgroundColor = UIColor(named: "Mint300")
        $0.layer.cornerRadius = 10
        $0.isHidden = true
    }
    
    private let nextButton = UIButton().then {
        $0.nextButton()
    }
    
    override func viewDidLoad() {
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
        questionProvider.request(.home(move_to_home: true, token: Token.accessToken ?? "")) { response in
            switch response {
            case let .success(response):
                switch response.statusCode {
                case 200:
                    self.navigationController?.popToRootViewController(animated: true)
                default:
                    print(response.statusCode)
                }
            case let .failure(error):
                print("fail :: \(error.localizedDescription)")
            }
        }
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
        if solutionButton.isHidden == true {
            questionProvider.request(.next(move_to_next_problem: true, token: Token.accessToken ?? "")) { response in
                switch response {
                case let .success(response):
                    switch response.statusCode {
                    case 200:
                        if self.solIndex < 14 {
                            self.solIndex += 1
                            self.solutionButton.isHidden = true
                            self.collectionView.isPagingEnabled = false
                            self.collectionView.scrollToItem(at: IndexPath(row: self.solIndex, section: 0), at: .left, animated: true)
                        } else {
                            self.buttonTapped()
                        }
                        print("true 보냄")
                    default:
                        print("실")
                    }
                case let .failure(error):
                    print("fail :: \(error.localizedDescription)")
                }
            }
        } else {
            if self.solIndex < 14 {
                self.solIndex += 1
                self.solutionButton.isHidden = true
                self.collectionView.isPagingEnabled = false
                self.collectionView.scrollToItem(at: IndexPath(row: self.solIndex, section: 0), at: .left, animated: true)
            } else {
                self.buttonTapped()
            }
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
            $0.correct = self.correct
            self.view.addSubview($0)
        }
        
        popup.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(270)
            $0.height.equalTo(297)
        }
        
        popup.updateResult(correctAnswers: correct)
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
        cell?.delegate = self
        
        cell?.solutionSelected = { [weak self] solution in
            guard let self = self else { return }
            self.solutionButton.isHidden = solution
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
        return questionsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
extension QuestionViewController: QuestionCellDelegate {
    func didSelectAnswer(answerId: Int) {
        self.answerId = answerId
    }
    func didUpdateCorrectAnswer(correct: Int) {
        self.correct = correct
    }
}
