//
//  GameViewController.swift
//  Racing2D
//
//  Created by Даниил on 25.11.24.
//

import UIKit

// MARK: - Constants

private enum Constants {
    static let grassWigth: CGFloat = 75
    static let markupWigth: CGFloat = 6
    
    static let grassAnimDuration: TimeInterval = 3
    
    static let grassLeftImage = "GrassLeft"
    static let grassRightImage = "GrassRight"
}

class GameViewController: UIViewController {
    // MARK: - Properties
    
    private let leftView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let rightView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let markupView: MarkupView = {
        let view = MarkupView()
        view.backgroundColor = .clear
        return view
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        startAnimations()
    }
}

private extension GameViewController {
    // MARK: - Methods
    
    func configureUI() {
        view.backgroundColor = .darkGray
        
        initLeftView()
        initRightView()
        initCenterView()
    }
    
    func initLeftView() {
        leftView.frame = CGRect(
            x: .zero,
            y: -view.frame.height,
            width: Constants.grassWigth,
            height: view.frame.height * 2
        )
        view.addSubview(leftView)
        
        let firstImage = UIImageView(image: UIImage(named: Constants.grassLeftImage))
        firstImage.frame = CGRect(
            x: .zero,
            y: .zero,
            width: Constants.grassWigth,
            height: view.frame.height
        )
        leftView.addSubview(firstImage)
        
        let secondImage = UIImageView(image: UIImage(named: Constants.grassLeftImage))
        secondImage.frame = CGRect(
            x: .zero,
            y: view.frame.height,
            width: Constants.grassWigth,
            height: view.frame.height
        )
        leftView.addSubview(secondImage)
    }
    
    func initRightView() {
        rightView.frame = CGRect(
            x: view.frame.width - Constants.grassWigth,
            y: -view.frame.height,
            width: Constants.grassWigth,
            height: view.frame.height * 2
        )
        view.addSubview(rightView)
        
        let firstImage = UIImageView(image: UIImage(named: Constants.grassRightImage))
        firstImage.frame = CGRect(
            x: .zero,
            y: .zero,
            width: Constants.grassWigth,
            height: view.frame.height
        )
        rightView.addSubview(firstImage)
        
        let secondImage = UIImageView(image: UIImage(named: Constants.grassRightImage))
        secondImage.frame = CGRect(
            x: .zero,
            y: view.frame.height,
            width: Constants.grassWigth,
            height: view.frame.height
        )
        rightView.addSubview(secondImage)
    }
    
    func initCenterView() {
        let centerView = UIView()
        centerView.frame = CGRect(
            x: leftView.frame.maxX,
            y: .zero,
            width: rightView.frame.minX - leftView.frame.maxX,
            height: view.frame.height
        )
        view.addSubview(centerView)
        
        markupView.frame = CGRect(
            x: .zero,
            y: -centerView.frame.height,
            width: centerView.frame.width,
            height: centerView.frame.height * 2
        )
        centerView.addSubview(markupView)
    }
    
    func startAnimations() {
        UIView.animate(withDuration: Constants.grassAnimDuration, delay: .zero, options: [.curveLinear, .repeat]) {
            self.leftView.frame.origin.y += self.view.frame.height
            self.rightView.frame.origin.y += self.view.frame.height
            self.markupView.frame.origin.y += self.view.frame.height
        }
        
        stopAnimations()
    }
    
    func stopAnimations() {
        leftView.layer.removeAllAnimations()
        rightView.layer.removeAllAnimations()
        markupView.layer.removeAllAnimations()
    }
}
