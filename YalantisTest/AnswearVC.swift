//
//  AnswearVC.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 18.10.2021.
//

import UIKit

class AnswearVC: UIViewController {
    let containerView = UIView()
    let titleLabel = UILabel()
    let messageLabel = UILabel()
    let actionButton = UIButton()
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 24
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }
    
    // MARK: - Private helpers
    private func configureContainerView() {
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),
            containerView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            containerView.heightAnchor.constraint(
                equalToConstant: 220
            ),
            containerView.widthAnchor.constraint(
                equalToConstant: 280
            ),
        ])
    }
    
    private func configureTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: containerView.topAnchor,
                constant: padding
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: padding
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: -padding
            ),
            titleLabel.heightAnchor.constraint(
                equalToConstant: 32
            )
        ])
    }
    
    private func configureMessageLabel() {
        messageLabel.textAlignment = .center
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(messageLabel)
        messageLabel.text = message ?? "Error appeared, unable to complete request"
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 8
            ),
            messageLabel.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: padding
            ),
            messageLabel.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: -padding
            ),
            messageLabel.bottomAnchor.constraint(
                equalTo: actionButton.topAnchor,
                constant: -padding)
        ])
    }
    
    private func configureActionButton() {
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "Accept", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor,
                constant: -padding
            ),
            actionButton.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: padding
            ),
            actionButton.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: -padding
            ),
            actionButton.heightAnchor.constraint(
                equalToConstant: 44
            )
        ])
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
   
}
