//
//  ViewController.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 18.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let titleLabel = UILabel()
    let subtitleLable = UILabel()
    
    var isShaking = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureLabels()
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
            self.isShaking = false
            self.presentAnswear()
        }
    }
    
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            self.isShaking = false
            self.presentAnswear()
        }
    }

    func presentAnswear() {
        DispatchQueue.main.async { [weak self] in
            let alertVC = AnswearVC(title: "Title", message: "Here's Your answear", buttonTitle: "Ok")
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self?.present(alertVC, animated: true, completion: nil)
        }
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

