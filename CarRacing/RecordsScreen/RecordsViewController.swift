//
//  RecordsViewController.swift
//  CarRacing
//
//  Created by Ilyas Tyumenev on 10.02.2024.
//

import UIKit

class RecordsViewController: UIViewController {

    // MARK: - let/var
    
    private let records = RecordsAPI.showRecords()
    private let tableView = UITableView()

    // MARK: - lifecycle funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conformProtocols()
        registerCells()
        configureViewController()
        setupNavigationBar()
        configureTableView()
        setSubviews()
        setUpConstraints()
    }
    
    // MARK: - flow funcs
    
    private func conformProtocols() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func registerCells() {
        tableView.register(RecordTableViewCell.self, forCellReuseIdentifier: RecordTableViewCell.identifier)
    }
    
    private func configureViewController() {
        navigationItem.title = "Records"
        navigationController?.navigationBar.barTintColor = .orange
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func setupNavigationBar() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "backImage"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let backButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backButtonItem
    }
    
    private func configureTableView() {
        tableView.allowsSelection = false
        tableView.separatorStyle = .singleLine
        tableView.separatorInset.left = 0
    }
    
    private func setSubviews() {
        view.addSubview(tableView)
    }
    
    private func setUpConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource

extension RecordsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecordTableViewCell.identifier, 
                                                 for: indexPath) as! RecordTableViewCell
        cell.record = records[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate

extension RecordsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

// MARK: - target actions
extension RecordsViewController {
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
