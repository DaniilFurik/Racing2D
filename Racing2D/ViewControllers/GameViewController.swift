//
//  GameViewController.swift
//  Racing2D
//
//  Created by Даниил on 25.11.24.
//

import UIKit

// MARK: - Constants

private enum Constants {
    static let bigFontSize: CGFloat = 48
    static let fontSize: CGFloat = 24
    static let scoreWidth: CGFloat = 125
    static let startGameSize: CGFloat = 200
    static let carWigth: CGFloat = 70
    static let carHeight: CGFloat = 150
    static let barrierWidth: CGFloat = 50
    static let barrierHeight: CGFloat = 50
    static let step: CGFloat = 20
    static let grassWigth: CGFloat = 65
    static let markupWigth: CGFloat = 6
    
    static let intersectionDelay: TimeInterval = 0.01
    static let barrierDelay: TimeInterval = 1.5
    static let animDuration: TimeInterval = 4
    static let defaultAnimDuration: TimeInterval = 0.3
    
    static let grassLeftImage = "GrassLeft"
    static let grassRightImage = "GrassRight"
    
    static let scoreText = "Score:"
    static let gameOverText = "Game Over"
    static let restartText = "Restart"
    static let closeGameText = "Close Game"
    static let yourScoreText = "Your score:"
    static let startGameText = "Let's Go"
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
    
    private let startGameLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.startGameText
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: Constants.bigFontSize, weight: .bold)
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private var barrierList = [UIImageView]()
    private var intersectionTimer: Timer?
    private var barrierTimer: Timer?
    private let controlRecognizer = UITapGestureRecognizer()
    private var animHeight: CGFloat = .zero
    private var score = Int.zero {
        didSet {
            scoreLabel.text = "\(Constants.scoreText) \(score)"
        }
    }
    private var gameSpeedMult = GlobalConstants.slowGameSpeed
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData()
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
    
    func initData() {
        // барьер должен пройти немного больше высоты экрана, поэтому используем эту переменную вместо высоты экрана
        // чтобы анимация разметки, обочины и барьеров была с одной скоростью
        animHeight = view.frame.height + Constants.barrierHeight
        
        switch Manager.shared.appSettings.gameSpeed {
        case .fast:
            gameSpeedMult = GlobalConstants.fastGameSpeed
            
        case .medium:
            gameSpeedMult = GlobalConstants.mediumGameSpeed
            
        case .slow:
            gameSpeedMult = GlobalConstants.slowGameSpeed
        }
    }
    
    func configureUI() {
        view.backgroundColor = .darkGray
        view.addGestureRecognizer(controlRecognizer)
        controlRecognizer.addTarget(self, action: #selector(tranclationCar))
        
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

        carImageView.image = UIImage(named: Manager.shared.appSettings.carImage)
        centerView.addSubview(carImageView)
        
        startGameLabel.frame = CGRect(
            x: centerView.frame.width / 2 - Constants.startGameSize / 2,
            y: centerView.frame.height / 2 - Constants.startGameSize / 2,
            width: Constants.startGameSize,
            height: Constants.startGameSize
        )
        centerView.addSubview(startGameLabel)
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
        
        scoreLabel.font = .systemFont(ofSize: Constants.fontSize, weight: .bold)
        scoreLabel.text = "\(Constants.scoreText) \(score)"
        scoreLabel.frame = scoreView.bounds
        scoreView.addSubview(scoreLabel)
    }
    
    func startGame() {
        // Анимируем label начала игры
        drawStartLabel()
        
        // пересоздаем таймеры
        createTimers()
        
        // анимируем обочину и машину
        initAnimatedViews()
    }
    
    func drawStartLabel() {
        startGameLabel.isHidden = false
        
        UIView.animate(withDuration: Constants.barrierDelay) {
            self.startGameLabel.alpha = 0
            self.startGameLabel.transform = CGAffineTransform(scaleX: 2, y: 2)
        } completion: { _ in
            self.startGameLabel.alpha = 1
            self.startGameLabel.isHidden = true
            self.startGameLabel.transform = .identity
        }
    }
    
    func initAnimatedViews() {
        self.carImageView.frame = CGRect(
            x: centerView.frame.width / 4 - Constants.carWigth / 2,
            y: centerView.frame.height - Constants.carHeight * 1.25,
            width: Constants.carWigth,
            height: Constants.carHeight
        )
        
        _ = Timer.scheduledTimer(withTimeInterval: Constants.barrierDelay, repeats: false, block: { [self] timer in
            UIView.animate(withDuration: Constants.animDuration * gameSpeedMult, delay: .zero, options: [.curveLinear, .repeat]) { [self] in
                leftView.frame.origin.y += animHeight
                rightView.frame.origin.y += animHeight
                markupView.frame.origin.y += animHeight
            }
        })
    }
    
    func stopGame() {
        // сохраняем результат
        Manager.shared.saveRecord(score)
        
        // cбрасываем таймеры и view
        resetViews()
        resetTimers()
        
        // показываем результат
        showResultAlert()
        
        // чистим барьеры ?!?!?!?!?!
        for barrierView in barrierList {
            barrierView.removeFromSuperview()
        }
        barrierList.removeAll()
    }
    
    func showResultAlert() {
        let alert = UIAlertController(title: Constants.gameOverText, message: "\(Constants.yourScoreText) \(score)", preferredStyle: .alert)
        alert.view.tintColor = .systemGreen
        alert.addAction(UIAlertAction(title: Constants.closeGameText, style: .cancel, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: Constants.restartText, style: .default, handler: { _ in
            self.score = .zero
            self.startGame()
        }))
        present(alert, animated: true)
    }
    
    @objc func addBarrier() {
        let barrierView = UIImageView()
        barrierView.image = UIImage(named: Manager.shared.getBarrierImage())
        barrierView.isUserInteractionEnabled = false
        barrierView.frame = CGRect(
            x: .random(in: .zero ... centerView.frame.width - Constants.barrierWidth),
            y: -Constants.barrierHeight,
            width: Constants.barrierWidth,
            height: Constants.barrierHeight
        )
        centerView.addSubview(barrierView)
        barrierList.append(barrierView)
        
        UIView.animate(withDuration: Constants.animDuration * gameSpeedMult, delay: .zero, options: [.curveLinear]) {
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
        let mult = controlRecognizer.location(in: view).x > view.center.x ? 1 : -1
        
        UIView.animate(withDuration: Constants.defaultAnimDuration) {
            self.carImageView.frame.origin.x += Constants.step * CGFloat(mult)
        }
    }
    
    func createTimers() {
        intersectionTimer = Timer.scheduledTimer(
            withTimeInterval: Constants.intersectionDelay,
            repeats: true,
            block: { _ in self.checkIntersection() }
        )
        
        barrierTimer = Timer.scheduledTimer(
            withTimeInterval: Constants.barrierDelay,
            repeats: true,
            block: { _ in self.addBarrier() }
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
