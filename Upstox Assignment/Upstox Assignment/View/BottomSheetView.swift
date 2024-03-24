import UIKit

class BottomSheetView: UIView {

    // MARK: - Constants

    private static let currentValueLabelText = "Current Value:"
    private static let totalInvestmentLabelText = "Total Investment:"
    private static let todaysPAndLLabelText = "Today's Profit & Loss:"
    private static let pAndLLabelText = "Profit & Loss:"

    // MARK: - Lazy Properties

    private lazy var expandIcon: UIImageView = {
        let expandImage = UIImageView(image: UIImage(systemName: "chevron.down"))
        expandImage.tintColor = .purple
        expandImage.translatesAutoresizingMaskIntoConstraints = false
        return expandImage
    }()

    private lazy var currentValueLabel: UILabel = {
        let label = UILabel()
        label.text = Self.currentValueLabelText
        label.font = UIFont.boldSystemFont(ofSize: 2 * UpstoxShareCell.cellInternalSpacing)
        label.numberOfLines = 1
        return label
    }()

    private lazy var totalInvestmentLabel: UILabel = {
        let label = UILabel()
        label.text = Self.totalInvestmentLabelText
        label.font = UIFont.boldSystemFont(ofSize: 2 * UpstoxShareCell.cellInternalSpacing)
        label.numberOfLines = 1
        return label
    }()

    private lazy var todaysPAndLLabel: UILabel = {
        let label = UILabel()
        label.text = Self.todaysPAndLLabelText
        label.font = UIFont.boldSystemFont(ofSize: 2 * UpstoxShareCell.cellInternalSpacing)
        label.numberOfLines = 1
        return label
    }()

    private lazy var pandLLabel: UILabel = {
        let label = UILabel()
        label.text = Self.pAndLLabelText
        label.font = UIFont.boldSystemFont(ofSize: 2 * UpstoxShareCell.cellInternalSpacing)
        label.numberOfLines = 1
        return label
    }()

    private lazy var leadingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = UpstoxShareCell.cellInternalSpacing
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var currentValue: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()

    private lazy var totalInvestment: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()

    private lazy var todaysPAndL: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()

    private lazy var pAndL: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()

    private lazy var trailingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.spacing = UpstoxShareCell.cellInternalSpacing
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - setup

    private func setupView() {
        self.backgroundColor = .systemBackground

        self.leadingStackView.addArrangedSubview(currentValueLabel)
        self.leadingStackView.addArrangedSubview(totalInvestmentLabel)
        self.leadingStackView.addArrangedSubview(todaysPAndLLabel)
        self.leadingStackView.addArrangedSubview(pandLLabel)
        self.trailingStackView.addArrangedSubview(currentValue)
        self.trailingStackView.addArrangedSubview(totalInvestment)
        self.trailingStackView.addArrangedSubview(todaysPAndL)
        self.trailingStackView.addArrangedSubview(pAndL)

        self.addSubview(self.expandIcon)
        self.addSubview(self.leadingStackView)
        self.addSubview(self.trailingStackView)

        NSLayoutConstraint.activate([
            self.expandIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: UpstoxShareCell.cellInternalSpacing / 2),
            self.expandIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            self.leadingStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2 * UpstoxShareCell.cellInternalSpacing),
            self.leadingStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 3 * UpstoxShareCell.cellInternalSpacing),
            self.leadingStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3 * UpstoxShareCell.cellInternalSpacing),

            self.trailingStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2 * UpstoxShareCell.cellInternalSpacing),
            self.trailingStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 3 * UpstoxShareCell.cellInternalSpacing),
            self.trailingStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3 * UpstoxShareCell.cellInternalSpacing)
        ])
    }

    // MARK: - Data Binding

    public func bind() {
        self.currentValue.text = UpstoxShareCell.rupeesString + String(UpstoxShareViewModel.calculateTotalCurrentValue())
        self.totalInvestment.text = UpstoxShareCell.rupeesString + String(UpstoxShareViewModel.calculateTotalInvestmentValue())
        self.todaysPAndL.text = UpstoxShareCell.rupeesString +  String(UpstoxShareViewModel.calculateTodaysProfitAndLoss())
        self.pAndL.text = UpstoxShareCell.rupeesString + String(
            UpstoxShareViewModel.calculateTotalCurrentValue()
            - UpstoxShareViewModel.calculateTotalInvestmentValue())
    }
}

