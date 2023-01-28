import UIKit
import Combine

class EmployeeDirectoryViewController: UIViewController {

    private let viewModel = EmployeeDirectoryViewModel(network: Network(endpoint: .directory))
    
    private var state: State? = .none {
        didSet { updateUI() }
    }
    
    private var cancellable: AnyCancellable?
    
    private lazy var errorView: ErrorView = {
        let view = ErrorView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.refreshControl = refreshControl
        tableView.register(EmployeeTableViewCell.self, forCellReuseIdentifier: "EmployeeTableViewCell")
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(fetchAndReload), for: .valueChanged)
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = NSLocalizedString("Employee Directory", comment: "title")
        
        load()
    }

    private func load() {
        refreshControl.beginRefreshing()
        cancellable = viewModel
            .fetch()
            .sink(receiveValue: { [weak self] state in
                guard let self = self else { return }
                self.state = state
                self.refreshControl.endRefreshing()
            })
    }
    
    private func updateUI() {
        if viewModel.showError {
            errorView.setup(with: viewModel.error)
            view.addSubview(errorView)
            
            NSLayoutConstraint.activate([
                errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                errorView.topAnchor.constraint(equalTo: view.topAnchor),
                errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        } else {
            view.addSubview(tableView)
            tableView.backgroundColor = .white
            
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }
    }

    @objc private func fetchAndReload() {
        refreshControl.beginRefreshing()
        cancellable = viewModel.fetch()
            .sink(receiveValue: { [weak self] state in
                guard let self = self else { return }
                self.state = state
                self.refreshControl.endRefreshing()
            })
    }
}

extension EmployeeDirectoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.employees.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeTableViewCell", for: indexPath) as! EmployeeTableViewCell
        if let employee = viewModel.employees.at(indexPath.row) {
            cell.setup(with: employee)
        }
        return cell
    }
}

extension EmployeeDirectoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
}

public extension Array {
    func at(_ index: Int) -> Element? {
        guard index < count && index >= 0 else { return nil }
        return self[index]
    }
}
