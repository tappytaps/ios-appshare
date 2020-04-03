//
//  AppShareViewController.swift
//  AppShare
//
//  Created by Lukas Boura on 31/03/2020.
//

import UIKit

class AppShareViewController: UIViewController {
    
    // MARK: Views
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private var cells: [ShareServiceCell] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: Dependencies
    
    private let request: AppShareRequest
    
    // MARK: Initialization
    
    init(request: AppShareRequest) {
        self.request = request
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItem()
        setupViews()
        setupLayout()
    }
    
}

// MARK: - Private API

private extension AppShareViewController {
    
    // MARK: Setup
    
    func setupNavigationItem() {
        navigationItem.title = "Share app"
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .always
        }
        let closeButton = UIBarButtonItem(
            image: .bundleImage(named: "close"),
            style: .plain,
            target: self,
            action: #selector(closeButtonAction)
        )
        if #available(iOS 13.0, *) {
            closeButton.tintColor = .systemGray
        } else {
            closeButton.tintColor = .gray
        }
        navigationItem.leftBarButtonItem = closeButton
    }
    
    func setupViews() {
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        cells = ShareService.allCases
            .filter(\.isAvailable)
            .map(ShareServiceCell.init)
    }
    
    func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    // MARK: Action
    
    @objc func closeButtonAction() {
        dismiss(animated: true)
    }
    
}

extension AppShareViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cells[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        cells[indexPath.row].service.share(request, from: self)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Recommend the app to your friends"
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let headerView = UIView()
        headerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 12),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -12),
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16)
        ])
        
        return headerView
    }
    
}
