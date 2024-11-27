//
//  GameViewController.swift
//  Racing2D
//
//  Created by Даниил on 25.11.24.
//

import UIKit

// MARK: - Constants

private enum Constants {
    static let carWigth: CGFloat = 75
    static let carHeight: CGFloat = 150
    static let barrierWidth: CGFloat = 50
    static let barrierHeight: CGFloat = 50
    static let step: CGFloat = 30
    static let grassWigth: CGFloat = 75
    static let markupWigth: CGFloat = 6
    
    static let delay: TimeInterval = 1.5
    static let animDuration: TimeInterval = 4
    static let defaultAnimDuration = 0.3
    
    static let grassLeftImage = "GrassLeft"
    static let grassRightImage = "GrassRight"
}

class GameViewController: UIViewController {
    // MARK: - Properties
    
    private let centerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private let leftView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private let rightView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private let markupView: MarkupView = {
        let view = MarkupView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        return view
    }()

    private let carImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private let controlRecognizer = UITapGestureRecognizer()
    private var animHeight: CGFloat = 0
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        startGame()
    }
}

private extension GameViewController {
    // MARK: - Methods
    
    func configureUI() {
        view.backgroundColor = .darkGray
        view.addGestureRecognizer(controlRecognizer)
        controlRecognizer.addTarget(self, action: #selector(tranclationCar))
        
        animHeight = view.frame.height + Constants.barrierHeight
        
        initLeftView()
        initRightView()
        initCenterView()
    }
    
    func initLeftView() {
        leftView.frame = CGRect(
            x: .zero,
            y: -animHeight,
            width: Constants.grassWigth,
            height: animHeight * 2
        )
        view.addSubview(leftView)
        
        let firstImage = UIImageView(image: UIImage(named: Constants.grassLeftImage))
        firstImage.frame = CGRect(
            x: .zero,
            y: .zero,
            width: Constants.grassWigth,
            height: animHeight
        )
        leftView.addSubview(firstImage)
        
        let secondImage = UIImageView(image: UIImage(named: Constants.grassLeftImage))
        secondImage.frame = CGRect(
            x: .zero,
            y: animHeight,
            width: Constants.grassWigth,
            height: animHeight
        )
        leftView.addSubview(secondImage)
    }
    
    func initRightView() {
        rightView.frame = CGRect(
            x: view.frame.width - Constants.grassWigth,
            y: -animHeight,
            width: Constants.grassWigth,
            height: animHeight * 2
        )
        view.addSubview(rightView)
        
        let firstImage = UIImageView(image: UIImage(named: Constants.grassRightImage))
        firstImage.frame = CGRect(
            x: .zero,
            y: .zero,
            width: Constants.grassWigth,
            height: animHeight
        )
        rightView.addSubview(firstImage)
        
        let secondImage = UIImageView(image: UIImage(named: Constants.grassRightImage))
        secondImage.frame = CGRect(
            x: .zero,
            y: animHeight,
            width: Constants.grassWigth,
            height: animHeight
        )
        rightView.addSubview(secondImage)
    }
    
    func initCenterView() {
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
            height: animHeight * 2
        )
        centerView.addSubview(markupView)

        carImageView.image = UIImage(named: Manager.shared.settingModel.carImage)
        centerView.addSubview(carImageView)
    }
    
    func startGame() {
        UIView.animate(withDuration: Constants.animDuration, delay: .zero, options: [.curveLinear, .repeat]) {
            self.leftView.frame.origin.y += self.animHeight
            self.rightView.frame.origin.y += self.animHeight
            self.markupView.frame.origin.y += self.animHeight
        }
        
        carImageView.frame = CGRect(
            x: centerView.frame.width / 4 - Constants.carWigth / 2,
            y: centerView.frame.height - Constants.carHeight * 1.25,
            width: Constants.carWigth,
            height: Constants.carHeight
        )
        
        addBarrier()
    }
    
    func stopGame() {
        leftView.layer.removeAllAnimations()
        rightView.layer.removeAllAnimations()
        markupView.layer.removeAllAnimations()
    }
    
    func addBarrier() {
        let barrierView = UIImageView()
        barrierView.image = UIImage(named: Manager.shared.settingModel.barrierImage)
        barrierView.isUserInteractionEnabled = false
        barrierView.frame = CGRect(
            x: .random(in: .zero ... centerView.frame.width - Constants.barrierWidth),
            y: -Constants.barrierHeight,
            width: Constants.barrierWidth,
            height: Constants.barrierHeight
        )
        centerView.addSubview(barrierView)
        
        UIView.animate(withDuration: Constants.animDuration, delay: .zero, options: [.curveLinear]) {
            barrierView.frame.origin.y += self.animHeight
        }
        completion: { _ in
            barrierView.removeFromSuperview()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.delay) {
            self.addBarrier()
        }
    }
    
    @objc func tranclationCar() {
        let mult = controlRecognizer.location(in: view).x > view.center.x ? 1 : -1
        
        UIView.animate(withDuration: Constants.defaultAnimDuration) {
            self.carImageView.frame.origin.x += Constants.step * CGFloat(mult)
        }
    }
    
}
