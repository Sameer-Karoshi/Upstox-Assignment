import UIKit

class ViewController: UIViewController {

    // MARK: - Constants

    private static let navigationItemTitle = "Upstox Assignment"
    private static let navigatioBarHeight = 44.0
    private static let safeAreaHeight = 50.0
    private static let profitAndLossViewHeight = 75.0
    private static let bottomSheetViewHeight = 200.0
    private static let cellHeight = 64.0

    // MARK: - Lazy Properties

    private lazy var upstoxSharesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private lazy var profitAndLossView: ProfitAndLossView = {
        let view = ProfitAndLossView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profitAndLossViewOrBottomSheetViewTapped))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var bottomSheetView: BottomSheetView = {
        let view = BottomSheetView()
        view.isHidden = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profitAndLossViewOrBottomSheetViewTapped))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }()

    // MARK: - Overriden Method

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupActivityIndicator()
        self.activityIndicatorView.startAnimating()

        UpstoxShareViewModel.fetchUpstoxSahresUsingJSON(){ data in
            DispatchQueue.main.async { [weak self] in
                guard let self = self, data else {
                    return
                }

                self.profitAndLossView.bind()
                self.bottomSheetView.bind()
                self.upstoxSharesTableView.reloadData()
                self.activityIndicatorView.stopAnimating()
            }
        }

        self.setupView()
    }

    // MARK: - setup

    private func setupActivityIndicator() {
        self.activityIndicatorView.center = self.view.center
        self.view.addSubview(activityIndicatorView)
    }

    private func setupView() {
        self.view.backgroundColor = .systemGray5

        self.navigationItem.title = Self.navigationItemTitle
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.backgroundColor = .purple

        self.upstoxSharesTableView.dataSource = self
        self.upstoxSharesTableView.register(UpstoxShareCell.self, forCellReuseIdentifier: "reuseIndentifierForCell")

        self.view.addSubview(self.upstoxSharesTableView)
        self.view.addSubview(self.profitAndLossView)
        self.view.addSubview(self.bottomSheetView)

        let upstoxSharesTableViewHeight = (Self.cellHeight * 5.0 + Self.navigatioBarHeight + Self.safeAreaHeight)

        NSLayoutConstraint.activate([
            self.upstoxSharesTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.upstoxSharesTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.upstoxSharesTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.upstoxSharesTableView.heightAnchor.constraint(equalToConstant: upstoxSharesTableViewHeight),
            self.profitAndLossView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.profitAndLossView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.profitAndLossView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.profitAndLossView.heightAnchor.constraint(equalToConstant: Self.profitAndLossViewHeight),
            self.bottomSheetView.leadingAnchor.constraint(equalTo:  self.profitAndLossView.leadingAnchor),
            self.bottomSheetView.trailingAnchor.constraint(equalTo:  self.profitAndLossView.trailingAnchor),
            self.bottomSheetView.bottomAnchor.constraint(equalTo:  self.profitAndLossView.bottomAnchor),
            self.bottomSheetView.heightAnchor.constraint(equalToConstant: Self.bottomSheetViewHeight)
        ])
    }

    // MARK: - Action Handler

    @objc
    func profitAndLossViewOrBottomSheetViewTapped() {
        self.profitAndLossView.isHidden = !self.profitAndLossView.isHidden
        self.bottomSheetView.isHidden = !self.bottomSheetView.isHidden
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UpstoxShareViewModel.userHolding?.userHolding.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = upstoxSharesTableView.dequeueReusableCell(withIdentifier: "reuseIndentifierForCell") as? UpstoxShareCell,
              let upstoxShareArray = UpstoxShareViewModel.userHolding?.userHolding else {
            return UITableViewCell()
        }

        cell.bind(upstoxShare: upstoxShareArray[indexPath.row])
        return cell
    }
}

