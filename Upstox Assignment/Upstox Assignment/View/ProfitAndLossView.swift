import UIKit

class ProfitAndLossView: UIView {

    // MARK: - Constant

    private static let profitAndLossLabelText = "Profit & Loss: "

    // MARK: - Lazy Properties

    private lazy var expandIcon: UIImageView = {
        let expandImage = UIImageView(image: UIImage(systemName: "chevron.up"))
        expandImage.tintColor = .purple
        expandImage.translatesAutoresizingMaskIntoConstraints = false
        return expandImage
    }()

    private lazy var profitAndLossLabel: UILabel = {
        let label = UILabel()
        label.text = Self.profitAndLossLabelText
        label.font = UIFont.boldSystemFont(ofSize: 2 * UpstoxShareCell.cellInternalSpacing)
        label.numberOfLines = 1
        return label
    }()

    private lazy var leadingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = UpstoxShareCell.cellInternalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var profitAndLoss: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 2 * UpstoxShareCell.cellInternalSpacing)
        label.numberOfLines = 1
        return label
    }()

    private lazy var trailingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.spacing = UpstoxShareCell.cellInternalSpacing
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

        self.leadingStackView.addArrangedSubview(profitAndLossLabel)
        self.trailingStackView.addArrangedSubview(profitAndLoss)

        self.addSubview(self.expandIcon)
        self.addSubview(self.leadingStackView)
        self.addSubview(self.trailingStackView)

        NSLayoutConstraint.activate([
            self.expandIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: UpstoxShareCell.cellInternalSpacing / 2),
            self.expandIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            self.leadingStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2 * UpstoxShareCell.cellInternalSpacing),
            self.leadingStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: UpstoxShareCell.cellInternalSpacing),
            self.leadingStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -UpstoxShareCell.cellInternalSpacing),

            self.trailingStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2 * UpstoxShareCell.cellInternalSpacing),
            self.trailingStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: UpstoxShareCell.cellInternalSpacing),
            self.trailingStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -UpstoxShareCell.cellInternalSpacing)
        ])
    }

    // MARK: - Data Binding

    public func bind() {
        self.profitAndLoss.text = UpstoxShareCell.rupeesString + String(
            UpstoxShareViewModel.calculateTotalCurrentValue()
            - UpstoxShareViewModel.calculateTotalInvestmentValue())
    }
}

