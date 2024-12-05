//
//  RecordsViewController.swift
//  Racing2D
//
//  Created by Даниил on 25.11.24.
//

import UIKit

// MARK: - Constants

private enum Constants {
    static let verticalSpacing: CGFloat = 16
    static let horizontalSpacing: CGFloat = 16
    
    static let recordsTitle = "Records"
    static let recordCellId = "RecordCell"
}

class RecordsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: - Properties
    
    private var sortedRecords: Dictionary<String, [RecordModel]> = [:]
    private let titles = [GlobalConstants.fastGameSpeedName, GlobalConstants.mediumGameSpeedName, GlobalConstants.slowGameSpeedName]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // получаем группированный по скорости игры Dictionary
        sortedRecords = Manager.shared.getSortedRecords()
        configureUI()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        let titleLabel = UILabel()
        titleLabel.text = titles[section]
        titleLabel.textColor = .label
        titleLabel.font = .systemFont(ofSize: titleLabel.font.pointSize, weight: .semibold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: Constants.horizontalSpacing),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -Constants.horizontalSpacing / 4),
        ])

        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getRecordsForSection(section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.recordCellId, for: indexPath) as! RecordTableCell
        cell.initData(data: getRecordsForSection(indexPath.section)[indexPath.row])
        return cell
    }
}

private extension RecordsViewController {
    // MARK: - Methods
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        title = Constants.recordsTitle
        
        let bckgImage = BackgroundImageView()
        view.addSubview(bckgImage)
        
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecordTableCell.self, forCellReuseIdentifier: Constants.recordCellId)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            bckgImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            bckgImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            bckgImage.topAnchor.constraint(equalTo: view.topAnchor),
            bckgImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.verticalSpacing),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func getRecordsForSection(_ section: Int) -> [RecordModel] {
        switch section {
        case 0:
            return sortedRecords[GlobalConstants.fastGameSpeedName] ?? []
        case 1:
            return sortedRecords[GlobalConstants.mediumGameSpeedName] ?? []
        case 2:
            return sortedRecords[GlobalConstants.slowGameSpeedName] ?? []
        default:
            return []
        }
    }
}
