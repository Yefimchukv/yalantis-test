//
//  MagicBallVC.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 18.10.2021.
//

import UIKit
import CoreMotion

final class MagicBallVC: UIViewController {
    
    private let titleView = UIView()
    
    private let counterTitle = UILabel()
    private let counterResetBtn = UIButton()
    private var counterStackView = UIStackView()
    
    private let titleStandImage = UIImageView()
    private let titleBallImage = UIImageView()
    private let titleLabel = UILabel()
    
    private var isShaking = false
    private var isAnswerLoaded = false
    
    private var currentAnswer: PresentableAnswer?
    
    private let viewModel: BallViewModel
    
    private var motionManager = CMMotionManager()
    
    init(viewModel: BallViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        setCounter()
        configureCounter()
        configureTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.refreshAnswerProvider()
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            isShaking = true
            
            motionManager.startGyroUpdates(to: .main) { data, _ in
                guard let data = data else { return }
                
                UIView.animate(withDuration: 0.1) {
                    
                    self.titleView.layer.position.x -= data.rotationRate.z / 2
                    self.titleView.layer.position.y -= data.rotationRate.x / 2
                } completion: { _ in
                    UIView.animate(withDuration: 0.1) {
                        
                        self.titleView.layer.position.x += data.rotationRate.z / 2
                        self.titleView.layer.position.y += data.rotationRate.x / 2
                    }
                }
            }
            
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                
                if self.isShaking {
                    let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.impactOccurred()
                } else {
                    timer.invalidate()
                }
            }
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            handleMotion()
        }
    }
    
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            handleMotion()
        }
    }
    
    private func handleMotion() {
        isShaking = false
        isAnswerLoaded = false
        currentAnswer = nil
        motionManager.stopGyroUpdates()
        
        performRequest()
        
        loadWithAnimationsIfNeeded()
    }
    
    private func loadWithAnimationsIfNeeded() {
        UIView.animate(withDuration: 1, delay: 0, options: []) {
            self.titleBallImage.layer.position.y -= 32
        } completion: { _ in
            UIView.animate(withDuration: 1) {
                self.titleBallImage.transform = CGAffineTransform(rotationAngle: .pi)
                self.titleBallImage.transform = CGAffineTransform(rotationAngle: .pi * 2)
            } completion: {  _ in
                UIView.animate(withDuration: 1, delay: 0, options: []) {
                    
                    self.titleBallImage.layer.position.y += 32
                } completion: { _ in
                    
                    if self.isAnswerLoaded {
                        self.presentAnswer(title: self.currentAnswer?.answerTitle, message: self.currentAnswer?.answerSubtitle)
                    } else {
                        self.loadWithAnimationsIfNeeded()
                    }
                }
            }
        }
    }
    
    private func performRequest() {
        Task {
            do {
                let presentableAnswer = try await viewModel.fetchAnswer()
                
                let currentCount = viewModel.loadValue(with: KeychainsKey.predictionsCounter).value
                
                viewModel.saveAnswerData(answer: presentableAnswer)
                
                viewModel.saveCounterValue(of: currentCount, with: KeychainsKey.predictionsCounter)
                
                self.isAnswerLoaded = true
                
                updateCounter()
                
                self.currentAnswer = presentableAnswer
                
            } catch {
                if let ytError = error as? YTError {
                    self.isAnswerLoaded = true
                    self.currentAnswer = Answer(magic: Answer.Magic(answer: ytError.rawValue, type: L10n.Errors.UltimateUnknownError.title)).toPresentableAnswer()
                } else {
                    self.isAnswerLoaded = true
                    self.currentAnswer = Answer(magic: Answer.Magic(answer: L10n.Errors.UltimateUnknownError.message, type: L10n.Errors.UltimateUnknownError.title)).toPresentableAnswer()
                }
            }
        }
    }
    
    @objc private func resetCounter() {
        viewModel.resetValue(with: KeychainsKey.predictionsCounter)
        updateCounter()
    }
    
    private func updateCounter() {
        let currentPredictionsNumber = viewModel.loadValue(with: KeychainsKey.predictionsCounter).value
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.counterTitle.text = L10n.Counter.title + "\(currentPredictionsNumber)"
        }
    }
    
    private func presentAnswer(title: String?, message: String?) {
        guard let title = title, let message = message else { return }
        
        let alertVC = AnswerVC(title: title, message: message, buttonTitle: "Ok")
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        self.present(alertVC, animated: true, completion: nil)
    }
}

// MARK: - Private configures and constraints
private extension MagicBallVC {
    
    func configureVC() {
        view.backgroundColor = .systemBackground
    }
    
    func setCounter() {
        counterTitle.text = L10n.Counter.title + "\(viewModel.loadValue(with: KeychainsKey.predictionsCounter).value)"
        counterTitle.adjustsFontSizeToFitWidth = true
        counterTitle.translatesAutoresizingMaskIntoConstraints = false
        
        counterResetBtn.configuration?.buttonSize = .small
        counterResetBtn.configuration = .borderedTinted()
        counterResetBtn.configuration?.cornerStyle = .medium
        counterResetBtn.configuration?.baseForegroundColor = .systemCyan
        counterResetBtn.configuration?.baseBackgroundColor = .systemMint
        counterResetBtn.configuration?.title = L10n.Counter.btn
        counterResetBtn.translatesAutoresizingMaskIntoConstraints = false
        
        counterResetBtn.addTarget(self, action: #selector(resetCounter), for: .touchUpInside)
    }
    
    func configureCounter() {
        counterStackView = UIStackView(arrangedSubviews: [counterTitle, counterResetBtn])
        counterStackView.spacing = 16
        counterStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(counterStackView)
        
        NSLayoutConstraint.activate([
            counterStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            counterStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            counterStackView.heightAnchor.constraint(lessThanOrEqualToConstant: 32),
            counterStackView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor),
            
            counterTitle.widthAnchor.constraint(lessThanOrEqualTo: counterStackView.widthAnchor, multiplier: 0.66)
        ])
    }
    
    func configureTitle() {
        titleView.backgroundColor = .systemGray6
        titleView.layer.cornerRadius = 12
        titleView.layer.shadowOpacity = 0.3
        titleView.layer.shadowRadius = 2.0
        
        view.addSubview(titleView)
        
        titleStandImage.image = Asset.ballStand.image
        
        titleBallImage.image = Asset.ballCircle.image
        titleBallImage.layer.cornerRadius = 20
        titleBallImage.alpha = 0.9
        
        titleLabel.text = L10n.MagicBall.subtitle
        titleLabel.textColor = .systemRed
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.adjustsFontSizeToFitWidth = true
        
        titleView.addSubviews(titleStandImage, titleBallImage, titleLabel)
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleStandImage.translatesAutoresizingMaskIntoConstraints = false
        titleBallImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleView.topAnchor.constraint(greaterThanOrEqualTo: counterStackView.bottomAnchor, constant: 8),
            titleView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 1),
            titleView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/4),
            titleView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 4/6),
            
            titleStandImage.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            titleStandImage.centerYAnchor.constraint(equalTo: titleView.centerYAnchor, constant: 32),
            titleStandImage.widthAnchor.constraint(equalTo: titleView.heightAnchor, multiplier: 0.33),
            titleStandImage.heightAnchor.constraint(equalTo: titleStandImage.widthAnchor, multiplier: 0.5),
            
            titleBallImage.bottomAnchor.constraint(equalTo: titleStandImage.centerYAnchor),
            titleBallImage.centerXAnchor.constraint(equalTo: titleStandImage.centerXAnchor),
            titleBallImage.widthAnchor.constraint(equalTo: titleStandImage.widthAnchor),
            titleBallImage.heightAnchor.constraint(equalTo: titleBallImage.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: titleStandImage.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
