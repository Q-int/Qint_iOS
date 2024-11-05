import UIKit
import SnapKit
import Then
import DGCharts

class MyViewController: UIViewController {
    
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
    
    var pieChartView: PieChartView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        chart()
        add()
        layout()
    }
    
    
    private func attribute() {
        view.backgroundColor = UIColor(named: "Mint100")
        mainButton.addTarget(self, action: #selector(mainButtonTapped), for: .touchUpInside)
        reviewIncorrectButton.addTarget(self, action: #selector(reviewIncorrectButtonTapped), for: .
                                        touchUpInside)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    private func chart() {
        pieChartView = PieChartView()
        
        var entries = [
            PieChartDataEntry(value: 75, label: "정답"),
            PieChartDataEntry(value: 25, label: "오답"),
        ]
        
        let dataSet = PieChartDataSet(entries: entries, label: "")
        
        dataSet.colors = [
            UIColor(named: "Green100") ?? .green,
            UIColor(named: "Red100") ?? .red
        ]
        
        let data = PieChartData(dataSet: dataSet)
        pieChartView.data = data
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.multiplier = 1
        data.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        
        data.setValueFont(UIFont.systemFont(ofSize: 16, weight: .bold))
        data.setValueTextColor(.black)
        
        pieChartView.legend.verticalAlignment = .top
        pieChartView.legend.orientation = .vertical
        pieChartView.legend.xOffset = 20
        
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
        self.navigationController?.pushViewController(ReviewIncorrectViewController(), animated: true)
    }
    @objc private func mainButtonTapped() {
        self.navigationController?.popViewController(animated: true)
//        self.navigationController?.pushViewController(MainViewController(), animated: true)
    }
    @objc private func logoutButtonTapped() {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
}
