//
//  RecordsViewController.swift
//  Racing2D
//
//  Created by Даниил on 25.11.24.
//

import UIKit

// MARK: - Constants

private enum Constants {
    static let recordsTitle = "Records"
    static let recordCellId = "RecordCell"
}

class RecordsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: - Properties
    
    private var sortedRecords: Dictionary<String, [UserRecord]> = [:]
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
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .systemGroupedBackground.withAlphaComponent(0.5)
        backgroundView.roundCorners()
        headerView.addSubview(backgroundView)
        
        let titleLabel = UILabel()
        titleLabel.text = titles[section]
        titleLabel.textColor = .label
        titleLabel.font = .systemFont(ofSize: titleLabel.font.pointSize, weight: .semibold)
        
        headerView.addSubview(titleLabel)

        backgroundView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(GlobalConstants.verticalSpacing)
            make.bottom.equalToSuperview().inset(GlobalConstants.verticalSpacing)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(backgroundView.snp.left).offset(GlobalConstants.horizontalSpacing)
            make.right.equalTo(backgroundView.snp.right).inset(GlobalConstants.horizontalSpacing)
            make.top.equalTo(backgroundView.snp.top).offset(GlobalConstants.verticalSpacing)
            make.bottom.equalTo(backgroundView.snp.bottom).inset(GlobalConstants.verticalSpacing)
        }

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
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecordTableCell.self, forCellReuseIdentifier: Constants.recordCellId)
        view.addSubview(tableView)
        
        bckgImage.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(GlobalConstants.verticalSpacing)
        }
    }
    
    func getRecordsForSection(_ section: Int) -> [UserRecord] {
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
