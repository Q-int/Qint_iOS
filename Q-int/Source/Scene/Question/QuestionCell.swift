import UIKit
import SnapKit
import Then
import Moya

class QuestionCell: UICollectionViewCell {
    weak var delegate: QuestionCellDelegate?
    
    private let questionProvider = MoyaProvider<QuestionAPI>(session: Session(interceptor: AuthInterceptor.shared))
    static let identifier = "QuestionCell"
    
    private var index: Int = 0
    public var buttonSelect = [UIButton]()
    public var buttonLabel = [UILabel]()
    public var question: Question?
    private var answerId: Int = 0
    public var correct = false
    
    public var solutionSelected: ((Bool) -> Void)?
    private var solution = true
    
    private let questionView = UIView().then {
        $0.questionView()
    }
    
    public let questionLabel = UILabel().then {
        $0.questionLabel()
    }
    
    private let indexLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = UIColor.gray400
    }
    
    public let button1 = AnswerButton(type: .question)
    public let button2 = AnswerButton(type: .question)
    public let button3 = AnswerButton(type: .question)
    public let button4 = AnswerButton(type: .question)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        add()
        layout()
    }
    
    private func attribute() {
        [
            button1.answerButton,
            button2.answerButton,
            button3.answerButton,
            button4.answerButton
        ].forEach{ button in
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
        [
            button1.answerButton,
            button2.answerButton,
            button3.answerButton,
            button4.answerButton
        ].forEach{ buttonSelect.append($0) }
        [
            button1.answerLabel,
            button2.answerLabel,
            button3.answerLabel,
            button4.answerLabel
        ].forEach{ buttonLabel.append($0) }
    }
    
    private func add() {
        [
            questionView,
            indexLabel,
            button1,
            button2,
            button3,
            button4,
        ].forEach{ contentView.addSubview($0) }
        questionView.addSubview(questionLabel)
    }
    
    private func layout() {
        questionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(74)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(215)
        }
        questionLabel.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview().inset(15)
        }
        indexLabel.snp.makeConstraints {
            $0.top.equalTo(questionView.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        button1.snp.makeConstraints {
            $0.top.equalTo(indexLabel.snp.bottom).offset(30)
            $0.height.equalTo(75)
            $0.left.right.equalToSuperview().inset(20)
        }
        button2.snp.makeConstraints {
            $0.top.equalTo(button1.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(75)
        }
        button3.snp.makeConstraints {
            $0.top.equalTo(button2.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(75)
        }
        button4.snp.makeConstraints {
            $0.top.equalTo(button3.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(75)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        for button in buttonSelect {
            if button != sender {
                button.backgroundColor = UIColor.mint100
            }
        }
        if sender.backgroundColor == UIColor.mint100 {
            sender.backgroundColor = UIColor.mint200
            if let index = buttonSelect.firstIndex(of: sender) {
                answerId = index
            }
        } else {
            check()
        }
        if let index = buttonSelect.firstIndex(of: sender),
           let question = question {
            let selectedAnswerId = question.options[index].answer_id
            delegate?.didSelectAnswer(answerId: selectedAnswerId)
        }
    }
    
    public func configure(index: Int) {
        indexLabel.text = "\(index+1)/15"
        self.index = index
        for button in buttonSelect {
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
    }
    
    private func check() {
        for i in 0..<4 {
            buttonSelect[i].isEnabled = false
            if buttonSelect[i].backgroundColor == UIColor.mint200 {
                buttonSelect[i].backgroundColor = UIColor.mint100
            }
        }
        questionProvider.request(.judge(question_id: question!.question_id, answer_id: question!.options[answerId].answer_id, token: Token.accessToken ?? "")) { response in
            switch response {
            case let .success(response):
                do {
                    switch response.statusCode {
                    case 200:
                        self.solution = false
                        self.solutionSelected?(self.solution)
                        let answer = try JSONDecoder().decode(Answer.self, from: response.data)
                        if answer.isCorrect {
                            self.buttonSelect[self.answerId].layer.borderColor = UIColor.green100.cgColor
                            self.buttonSelect[self.answerId].layer.borderWidth = 3
                        } else {
                            self.buttonSelect[self.answerId].layer.borderColor = UIColor.red100.cgColor
                            self.buttonSelect[self.answerId].layer.borderWidth = 3
                            for i in 0..<4 {
                                if self.buttonLabel[i].text == answer.answerText {
                                    self.buttonSelect[i].layer.borderColor = UIColor.green100.cgColor
                                    self.buttonSelect[i].layer.borderWidth = 3
                                }
                            }
                        }
                        self.delegate?.didUpdateCorrectAnswer(correct: answer.isCorrect)
                    default:
                        print("error :: \(response.statusCode)")
                    }
                } catch {
                    print("Decoding or JSON parsing error: \(error)")
                }
            case let .failure(error):
                print("fail :: \(error.localizedDescription)")
            }
        }
    }
}
protocol QuestionCellDelegate: AnyObject {
    func didSelectAnswer(answerId: Int)
    func didUpdateCorrectAnswer(correct: Bool)
}
