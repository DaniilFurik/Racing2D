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
    
    static var identifier: String { "\(Self.self)" }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .systemGreen : .clear
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        isSelected = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureUI()
        roundCorners()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        imageView.image = UIImage(named: imageName)
    }
}
