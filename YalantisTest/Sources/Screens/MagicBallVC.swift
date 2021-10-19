//
//  ViewController.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 18.10.2021.
//

import UIKit

class MagicBallVC: UIViewController {
    
    let titleLabel = UILabel()
    let subtitleLable = UILabel()
    
    let defaults = UserDefaults.standard
    
    var isShaking = false
    
    let straightPredictionsList: [Answer] = [
        Answer(magic: Answer.Magic(question: "", answer: "HEAL YEAH!", type: "Positive")),
        Answer(magic: Answer.Magic(question: "", answer: "NO WAY", type: "Negative")),
        Answer(magic: Answer.Magic(question: "", answer: "50/50, it's up to you", type: "Neutral"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureLabels()
        defaults.removeObject(forKey: "lightTheme")
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
    
    
    private func handleMotion() {
        self.isShaking = false
        print(defaults.bool(forKey: SettingKeys.straightPredictions))
        if defaults.bool(forKey: SettingKeys.straightPredictions) {
            let straightAnswer = straightPredictionsList.randomElement()
            self.presentAnswer(title: straightAnswer?.magic.type, message: straightAnswer?.magic.answer)
        } else {
            
            Task {
                do {
                    let answer = try await NetworkService.shared.getAnswer()
                    presentAnswer(title: answer.magic.type, message: answer.magic.answer)
                } catch {
                    if let ytError = error as? YTError {
                        presentAnswer(title: "Ooops...", message: ytError.rawValue)
                    } else {
                        presentAnswer(title: "Ooops...", message: "Something unkown happened")
                    }
                }
            }
        }
    }
    
    
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            handleMotion()
        }
    }
    
    
    func presentAnswer(title: String?, message: String?) {
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
        titleLabel.text = "🔮"
        titleLabel.textAlignment = .center
        subtitleLable.text = "Shake Your iPhone to ask the GURU"
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLable.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLable)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            subtitleLable.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLable.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 8),
        ])
    }
}

