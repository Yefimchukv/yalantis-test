//
//  MagicBallVC.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 18.10.2021.
//

import UIKit

class MagicBallVC: UIViewController {
    
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
        configureLabels()
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
                let answer = try await viewModel.fetchAnswer()
                presentAnswer(title: answer.answerTitle, message: answer.answerSubtitle)
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
    
    private func presentAnswer(title: String?, message: String?) {
        guard let title = title, let message = message else { return }
        
        let alertVC = AnswerVC(title: title, message: message, buttonTitle: "Ok")
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        self.present(alertVC, animated: true, completion: nil)
    }
    
    // MARK: - Private helpers
    private func configureVC() {
        view.backgroundColor = .systemBackground
        
    }
    
    private func configureLabels() {
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