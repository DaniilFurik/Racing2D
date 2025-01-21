//
//  ImageListView.swift
//  Racing2D
//
//  Created by Даниил on 15.12.24.
//

import UIKit

class ImageListView: UIView {
    //MARK: - Properties
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = GlobalConstants.horizontalSpacing
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(ImageCollectionCell.self, forCellWithReuseIdentifier: ImageCollectionCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    private var images: [String] = []
    private var typeImage: TypeImage = .cars
    
    //MARK: - Constructor
    
    convenience init(images: [String], typeImage: TypeImage) {
        self.init()
        
        self.images = images
        self.typeImage = typeImage
        
        switch typeImage {
        case .cars:
            setSelectedCarImage()
        case .barriers:
            setSelectedBarrierImage()
        }
        
        configureUI()
    }
}

extension ImageListView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionCell.identifier, for: indexPath) as? ImageCollectionCell else { return UICollectionViewCell()}

        cell.initData(imageName: images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.height * 0.8
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch typeImage {
        case .cars:
            Manager.shared.appSettings.carImage = images[indexPath.row]
        case .barriers:
            Manager.shared.appSettings.barrierImage = images[indexPath.row]
        }
    }
    
    private func configureUI() {
        collectionView.contentInset = .init(
            top: .zero,
            left: GlobalConstants.horizontalSpacing,
            bottom: .zero,
            right: GlobalConstants.horizontalSpacing
        )
        
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    private func setSelectedCarImage() {
        let index = images.firstIndex(of: Manager.shared.appSettings.carImage) ?? 0
        
        //collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: false)
        collectionView.selectItem(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: .centeredHorizontally)
    }
    
    private func setSelectedBarrierImage() {
        let index = images.firstIndex(of: Manager.shared.appSettings.barrierImage) ?? 0
        
        //collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: false)
        collectionView.selectItem(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: .centeredHorizontally)
    }
}
