//
//  MagicBallVC.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 18.10.2021.
//

import UIKit

class MagicBallVC: UIViewController {
    
    private let counterTitle = UILabel()
    private let counterResetBtn = UIButton()
    
    private let titleLabel = UILabel()
    private let subtitleLable = UILabel()
    
    private var isShaking = false
    
    private var viewModel: BallViewModel!
    
    init(viewModel: BallViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTitle()
        setCounter()
        configureCounter()
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
            self.isShaking = true
            
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
                guard let self = self else { return }
                
                if self.isShaking {
                    let generator = UIImpactFeedbackGenerator(style: .medium)
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
        self.isShaking = false
        
        Task {
            do {
                let presentableAnswer = try await viewModel.fetchAnswer()
                let currentCount = viewModel.loadValue(with: KeychainsKey.predictionsCounter).value
                viewModel.saveAnswerData(answer: presentableAnswer)
                viewModel.saveCounterValue(of: currentCount, with: KeychainsKey.predictionsCounter)
                updateCounter()
                
                presentAnswer(title: presentableAnswer.answerTitle, message: presentableAnswer.answerSubtitle)
                
            } catch {
                if let ytError = error as? YTError {
                    presentAnswer(title: L10n.Errors.UltimateUnknownError.title,
                                  message: ytError.rawValue)
                } else {
                    presentAnswer(title: L10n.Errors.UltimateUnknownError.title,
                                  message: L10n.Errors.UltimateUnknownError.message)
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
        let stackView = UIStackView(arrangedSubviews: [counterTitle, counterResetBtn])
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 32),
            stackView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor),
            
            counterTitle.widthAnchor.constraint(lessThanOrEqualTo: stackView.widthAnchor, multiplier: 0.66)
        ])
    }
    
    func configureTitle() {
        titleLabel.text = L10n.MagicBall.title
        titleLabel.textAlignment = .center
        
        subtitleLable.text = L10n.MagicBall.subtitle
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLable.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubviews(titleLabel, subtitleLable)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            subtitleLable.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLable.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 8)
        ])
    }
}
