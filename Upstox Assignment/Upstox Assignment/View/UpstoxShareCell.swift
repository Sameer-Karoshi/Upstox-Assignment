import UIKit

class UpstoxShareCell: UITableViewCell {

    // MARK: - Constant

    public static let cellInternalSpacing = 8.0
    public static let rupeesString = "₹ "
    private static let ltpLabelPrefix = "LTP: " + rupeesString
    private static let pAndLLabelPrefix = "P/L: " + rupeesString

    // MARK: - Lazy Properties

    private lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 2 * Self.cellInternalSpacing)
        label.numberOfLines = 1
        label.setContentHuggingPriority(.defaultHigh + 1, for: .vertical)
        return label
    }()

    private lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 2 * Self.cellInternalSpacing)
        label.numberOfLines = 1
        return label
    }()

    private lazy var leadingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = Self.cellInternalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var ltpLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 2 * Self.cellInternalSpacing)
        label.numberOfLines = 1
        label.setContentHuggingPriority(.defaultHigh + 1, for: .vertical)
        return label
    }()

    private lazy var pAndLLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 2 * Self.cellInternalSpacing)
        label.numberOfLines = 1
        return label
    }()

    private lazy var trailingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.spacing = Self.cellInternalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - setup

    private func setupView() {
        self.backgroundColor = .systemBackground

        self.leadingStackView.addArrangedSubview(symbolLabel)
        self.leadingStackView.addArrangedSubview(quantityLabel)
        self.trailingStackView.addArrangedSubview(ltpLabel)
        self.trailingStackView.addArrangedSubview(pAndLLabel)

        self.contentView.addSubview(self.leadingStackView)
        self.contentView.addSubview(self.trailingStackView)

        let stackViewWidth = (self.contentView.frame.size.width * 0.5) - (2 * Self.cellInternalSpacing)
        NSLayoutConstraint.activate([
            self.leadingStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2 * Self.cellInternalSpacing),
            self.leadingStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Self.cellInternalSpacing),
            self.leadingStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Self.cellInternalSpacing),
            self.leadingStackView.widthAnchor.constraint(equalToConstant: stackViewWidth),

            self.trailingStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2 * Self.cellInternalSpacing),
            self.trailingStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Self.cellInternalSpacing),
            self.trailingStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Self.cellInternalSpacing),
            self.trailingStackView.widthAnchor.constraint(equalToConstant: stackViewWidth)
        ])
    }

    // MARK: - Data Binding

    public func bind(upstoxShare: UpstoxShare) {
        self.symbolLabel.text = upstoxShare.symbol
        self.quantityLabel.text = String(upstoxShare.quantity)

        let range = NSRange(location: 0, length: 4)
        let ltpLabelText = NSMutableAttributedString(string: Self.ltpLabelPrefix + String(upstoxShare.ltp))
        ltpLabelText.addAttribute(.font, value: UIFont.systemFont(ofSize: 2 * Self.cellInternalSpacing), range: range)
        self.ltpLabel.attributedText = ltpLabelText

        let pAndLLabelText = NSMutableAttributedString(
            string: Self.pAndLLabelPrefix +  String(UpstoxShareViewModel.calculatePandLValue(upstoxShare: upstoxShare)))
        pAndLLabelText.addAttribute(.font, value: UIFont.systemFont(ofSize: 2 * Self.cellInternalSpacing), range: range)
        self.pAndLLabel.attributedText = pAndLLabelText
    }
}

