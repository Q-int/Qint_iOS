import UIKit
import SnapKit
import Then
import DGCharts
import Moya

class MyViewController: UIViewController {
    
    private let userProvider = MoyaProvider<UserAPI>()
    private var correct = 10
    private var pieChartView = PieChartView()
    
    private let qintLabel = UILabel().then {
        $0.text = "Q-int"
        $0.font = UIFont(name: "ZenDots-Regular", size: 24)
        $0.textColor = UIColor(named: "Gray400")
    }
    
    private let mainButton = UIButton().then {
        $0.setImage(UIImage(named: "Home2"), for: .normal)
        $0.tintColor = UIColor(named: "Gray400")
        $0.imageView?.contentMode = .scaleAspectFill
        $0.contentHorizontalAlignment = .fill
        $0.contentVerticalAlignment = .fill
    }
    
    private let accuracyView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
    }
    
    private let reviewIncorrectLabel = UILabel().then {
        $0.text = "나의 정답률"
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = UIColor(named: "Gray400")
    }
    
    private let reviewIncorrectButton = UIButton().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
    }
    
    private let reviewIncorrectView = reviewIncorrect().then {
        $0.isUserInteractionEnabled = false
    }
    
    private let emailLabel = UILabel().then {
        $0.text = "오류 신고 이메일 : 1234@dsm.hs.kr"
        $0.font = .systemFont(ofSize: 10)
        $0.textColor = UIColor(named: "Gray400")
    }
    
    private let logoutButton = UIButton().then {
        $0.setTitle("로그아웃", for: .normal)
        $0.setTitleColor(UIColor(named: "Gray400"), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 10)
        $0.contentEdgeInsets = UIEdgeInsets(top: -1, left: 0, bottom: -1, right: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        getUserApi()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        add()
        layout()
    }
    
    private func getUserApi() {
        userProvider.request(.info(token: Token.accessToken ?? "")) { response in
            switch response {
            case let .success(response):
                do {
                    switch response.statusCode {
                    case 200:
                        let score = try JSONDecoder().decode(Score.self, from: response.data)
                        print(score)
                        
                        if (Double(score.correct_answers)/Double(15))*100 < 1 {
                            self.correct = 100
                        } else {
                            self.correct = Int((Double(score.correct_answers)/Double(15))*100)
                        }
                        print(score.correct_answers)
                        print(Double(score.correct_answers)/Double(15)*100)
                        print(self.correct)
                        DispatchQueue.main.async {
                            self.chart()
                        }
                    default:
                        print("실패 :: \(response.statusCode)")
                    }
                } catch {
                    print("catch :: \(error.localizedDescription)")
                }
            case let .failure(error):
                print("fail :: \(error.localizedDescription)")
            }
        }
    }
    
    private func attribute() {
        view.backgroundColor = UIColor(named: "Mint100")
        mainButton.addTarget(self, action: #selector(mainButtonTapped), for: .touchUpInside)
        reviewIncorrectButton.addTarget(self, action: #selector(reviewIncorrectButtonTapped), for: .
                                        touchUpInside)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    private func chart() {
        pieChartView.clear()
        
        var entries = [
            PieChartDataEntry(value: Double(correct), label: "정답"),
            PieChartDataEntry(value: Double(100 - correct), label: "오답")
        ]
        
        let dataSet = PieChartDataSet(entries: entries, label: "")
        
        dataSet.colors = [
            UIColor(named: "Green100") ?? .green,
            UIColor(named: "Red100") ?? .red
        ]
        
        let data = PieChartData(dataSet: dataSet)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.multiplier = 1
        data.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        
        data.setValueFont(UIFont.systemFont(ofSize: 16, weight: .bold))
        data.setValueTextColor(.black)
        
        pieChartView.legend.verticalAlignment = .top
        pieChartView.legend.orientation = .vertical
        pieChartView.legend.xOffset = 20
        
        pieChartView.data = data
        
        pieChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .easeInOutQuad)
    }
    
    private func add() {
        [
            qintLabel,
            mainButton,
            accuracyView,
            reviewIncorrectButton,
            emailLabel,
            logoutButton
        ].forEach{ view.addSubview($0) }
        reviewIncorrectButton.addSubview(reviewIncorrectView)
        accuracyView.addSubview(reviewIncorrectLabel)
        accuracyView.addSubview(pieChartView)
    }
    
    private func layout() {
        qintLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(71)
            $0.left.equalToSuperview().inset(30)
        }
        mainButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(71)
            $0.right.equalToSuperview().inset(30)
            $0.height.width.equalTo(30)
        }
        accuracyView.snp.makeConstraints {
            $0.top.equalTo(mainButton.snp.bottom).offset(27)
            $0.bottom.equalTo(reviewIncorrectButton.snp.bottom).inset(121)
            $0.left.right.equalToSuperview().inset(24)
        }
        reviewIncorrectLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(24)
        }
        pieChartView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(70)
            $0.left.right.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(30)
        }
        reviewIncorrectButton.snp.makeConstraints {
            $0.bottom.equalTo(emailLabel.snp.bottom).inset(160)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(80)
        }
        reviewIncorrectView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        emailLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(75)
            $0.left.equalToSuperview().inset(24)
        }
        logoutButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(75)
            $0.right.equalToSuperview().inset(24)
        }
    }
    
    @objc private func reviewIncorrectButtonTapped() {
        userProvider.request(.incorrect(token: Token.accessToken ?? "")) { response in
            switch response {
            case let .success(response):
                do {
                    switch response.statusCode {
                    case 200:
                        let incorrectAnswer = try JSONDecoder().decode(Incorrect.self, from: response.data)
                        let vc = ReviewIncorrectViewController()
                        vc.questionArray = incorrectAnswer.userIncorrectAnswerElementList
                        print(incorrectAnswer.userIncorrectAnswerElementList)
                        self.navigationController?.pushViewController(vc, animated: true)
                    default:
                        print("error :: \(response.statusCode)")
                    }
                } catch {
                    print("catch :: \(error.localizedDescription)")
                }
            case let .failure(error):
                print("fail :: \(error.localizedDescription)")
            }
        }
    }
    @objc private func mainButtonTapped() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @objc private func logoutButtonTapped() {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
}
