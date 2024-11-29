//
//  GameViewController.swift
//  Racing2D
//
//  Created by Даниил on 25.11.24.
//

import UIKit

// MARK: - Constants

private enum Constants {
    static let sizeFont: CGFloat = 24
    static let scoreWidth: CGFloat = 125
    static let carWigth: CGFloat = 75
    static let carHeight: CGFloat = 150
    static let barrierWidth: CGFloat = 50
    static let barrierHeight: CGFloat = 50
    static let step: CGFloat = 20
    static let grassWigth: CGFloat = 75
    static let markupWigth: CGFloat = 6
    
    static let intersectionDelay: TimeInterval = 0.1
    static let barrierDelay: TimeInterval = 1.5
    static let animDuration: TimeInterval = 4
    static let defaultAnimDuration = 0.3
    
    static let grassLeftImage = "GrassLeft"
    static let grassRightImage = "GrassRight"
    
    static let scoreText = "Score:"
    static let gameOverText = "Game Over"
    static let restartText = "Restart"
    static let yourScoreText = "Your score:"
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
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var barrierList =  [UIImageView]()
    private var intersectionTimer: Timer?
    private var barrierTimer: Timer?
    private let controlRecognizer = UITapGestureRecognizer()
    private var animHeight: CGFloat = 0
    private var score = 0 {
        didSet {
            scoreLabel.text = "\(Constants.scoreText) \(score)"
        }
    }
    private var isGamming = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        startGame()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // при закрытии контроллера не останавливаются, поэтому останавливаем тут
        resetTimers()
    }
}

private extension GameViewController {
    // MARK: - Methods
    
    func configureUI() {
        view.backgroundColor = .darkGray
        view.addGestureRecognizer(controlRecognizer)
        controlRecognizer.addTarget(self, action: #selector(tranclationCar))
        
        // барьер должен пройти немного больше высоты экрана, поэтому используем эту переменную вместо высоты экрана
        // чтобы анимация разметки, обочины и барьеров была с одной скоростью
        animHeight = view.frame.height + Constants.barrierHeight
        
        initLeftView()
        initRightView()
        initCenterView()
        initScoreView()
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
            height: leftView.frame.height / 2
        )
        leftView.addSubview(firstImage)
        
        let secondImage = UIImageView(image: UIImage(named: Constants.grassLeftImage))
        secondImage.frame = CGRect(
            x: .zero,
            y: leftView.frame.height / 2,
            width: Constants.grassWigth,
            height: leftView.frame.height / 2
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
            height: rightView.frame.height / 2
        )
        rightView.addSubview(firstImage)
        
        let secondImage = UIImageView(image: UIImage(named: Constants.grassRightImage))
        secondImage.frame = CGRect(
            x: .zero,
            y: rightView.frame.height / 2,
            width: Constants.grassWigth,
            height: rightView.frame.height / 2
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
    
    func initScoreView() {
        guard let frame = navigationController?.navigationBar.frame else { return }
        
        let scoreView = UIView()
        scoreView.frame = CGRect(
            x: view.frame.width - Constants.scoreWidth,
            y: frame.minY,
            width: Constants.scoreWidth,
            height: frame.height
        )
        view.addSubview(scoreView)
        
        scoreLabel.font = .systemFont(ofSize: Constants.sizeFont, weight: .bold)
        scoreLabel.text = "\(Constants.scoreText) \(score)"
        scoreLabel.frame = scoreView.bounds
        scoreView.addSubview(scoreLabel)
    }
    
    func startGame() {
        isGamming = true

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
    
        createTimers()
    }
    
    func stopGame() {
        isGamming = false
        
        resetViews()
        resetTimers()
        
        let alert = UIAlertController(title: Constants.gameOverText, message: "\(Constants.yourScoreText) \(score)", preferredStyle: .alert)
        alert.view.tintColor = .systemGreen
        alert.addAction(UIAlertAction(title: Constants.restartText, style: .default, handler: { _ in
            self.score = .zero
            self.startGame()
        }))
        present(alert, animated: true)
        
        for barrierView in barrierList {
            barrierView.removeFromSuperview()
        }
        barrierList.removeAll()
    }
    
    @objc func addBarrier() {
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
        barrierList.append(barrierView)
        
        UIView.animate(withDuration: Constants.animDuration, delay: .zero, options: [.curveLinear]) {
            barrierView.frame.origin.y += self.animHeight
        }
        completion: { _ in
            barrierView.removeFromSuperview()
        }
    }
    
    @objc func checkIntersection() {
        // если нет машины, то дальше не пойдем
        guard let carFrame = carImageView.layer.presentation()?.frame else { return }
        
        if carFrame.minX < .zero || carFrame.maxX > centerView.frame.width {
            stopGame()
        }
        
        var removeList = [UIImageView]()
        
        for item in barrierList {
            // если нет барьера, то игнорим его
            if let barrierFrame = item.layer.presentation()?.frame {
                if carFrame.maxY < barrierFrame.minY {
                    score += 1
                    removeList.append(item)
                } else {
                    if carFrame.intersects(barrierFrame) {
                        stopGame()
                    }
                }
            }
        }
        
        for item in removeList {
            barrierList.removeAll(where: { $0 === item })
        }
    }
    
    @objc func tranclationCar() {
        if isGamming {
            let mult = controlRecognizer.location(in: view).x > view.center.x ? 1 : -1
            
            UIView.animate(withDuration: Constants.defaultAnimDuration) {
                self.carImageView.frame.origin.x += Constants.step * CGFloat(mult)
            }
        }
    }
    
    func createTimers() {
        intersectionTimer = Timer.scheduledTimer(
            timeInterval: Constants.intersectionDelay,
            target: self,
            selector: #selector(checkIntersection),
            userInfo: nil,
            repeats: true
        )
        
        barrierTimer = Timer.scheduledTimer(
            timeInterval: Constants.barrierDelay,
            target: self,
            selector: #selector(addBarrier),
            userInfo: nil,
            repeats: true
        )
    }
    
    func resetTimers() {
        barrierTimer?.invalidate()
        barrierTimer = nil
        
        intersectionTimer?.invalidate()
        intersectionTimer = nil
    }
    
    func resetViews() {
        leftView.layer.removeAllAnimations()
        rightView.layer.removeAllAnimations()
        markupView.layer.removeAllAnimations()
        centerView.layer.removeAllAnimations()
        
        leftView.frame.origin.y = -animHeight
        rightView.frame.origin.y = -animHeight
        markupView.frame.origin.y = -animHeight
    }
}
