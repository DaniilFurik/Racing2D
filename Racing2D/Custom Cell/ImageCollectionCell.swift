//
//  ImageCollectionCell.swift
//  Racing2D
//
//  Created by Даниил on 15.12.24.
//

import UIKit
import SnapKit

class ImageCollectionCell: UICollectionViewCell {
    // MARK: - Properties
    
    static let identifier = "ImageCollectionCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .systemGreen : .clear
        }
    }
}

extension ImageCollectionCell {
    // MARK: - Methods
    
    private func configureUI() {
        contentView.addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    func initData(imageName: String) {
        configureUI()
        roundCorners()
        
        imageView.image = UIImage(named: imageName)
    }
}
