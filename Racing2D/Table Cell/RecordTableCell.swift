//
//  UserInfoTableCell.swift
//  Racing2D
//
//  Created by Даниил on 2.12.24.
//

import UIKit

// MARK: - Constants

private enum Constants {
    static let horizontalSpacing: CGFloat = 16
    static let verticalSpacing: CGFloat = 8
    
    static let smallFontSize: CGFloat = 12
    static let bigFontSize: CGFloat = 18
    
    static let usernameText = "Username: "
    static let scoreText = "Score: "
}

class RecordTableCell: UITableViewCell {
    // MARK: - Properties
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: Constants.bigFontSize, weight: .semibold)
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: Constants.bigFontSize, weight: .semibold)
        return label
    }()
    
    // MARK: - Constructor
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecordTableCell {
    // MARK: - Methods
    
    private func configureUI() {
        selectionStyle = .none

        contentView.addSubview(usernameLabel)
        contentView.addSubview(scoreLabel)
        
        let firstLabel = UILabel()
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        firstLabel.text = Constants.usernameText
        firstLabel.font = .systemFont(ofSize: Constants.smallFontSize)
        contentView.addSubview(firstLabel)
        
        let secondLabel = UILabel()
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.text = Constants.scoreText
        secondLabel.font = .systemFont(ofSize: Constants.smallFontSize)
        contentView.addSubview(secondLabel)
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.verticalSpacing),
            usernameLabel.leftAnchor.constraint(equalTo: firstLabel.rightAnchor),
            usernameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Constants.horizontalSpacing),
            
            firstLabel.firstBaselineAnchor.constraint(equalTo: usernameLabel.firstBaselineAnchor),
            firstLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.horizontalSpacing),
            
            secondLabel.firstBaselineAnchor.constraint(equalTo: scoreLabel.firstBaselineAnchor),
            secondLabel.leftAnchor.constraint(equalTo: firstLabel.leftAnchor),
            
            scoreLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: Constants.verticalSpacing),
            scoreLabel.leftAnchor.constraint(equalTo: secondLabel.rightAnchor),
            scoreLabel.rightAnchor.constraint(equalTo: usernameLabel.rightAnchor),
            scoreLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.verticalSpacing)
        ])
    }
    
    func initData(data: RecordModel) {
        usernameLabel.text = data.username
        scoreLabel.text = data.score.description
    }
}
