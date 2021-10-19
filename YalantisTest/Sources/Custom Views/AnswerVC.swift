//
//  AnswerVC.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 18.10.2021.
//

import UIKit

class AnswerVC: UIViewController {
    
    let containerView = UIView()
    let titleLabel = UILabel()
    let messageLabel = UILabel()
    let actionButton = UIButton()
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 16
    
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
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubviews(containerView, titleLabel, titleLabel, messageLabel, actionButton)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
        
    // MARK: - Private helpers
    private func configureContainerView() {
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
        titleLabel.text = alertTitle ?? "I'd just found the answer, but something went wrong"
        
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
        messageLabel.text = message ?? "Ooops, not this time"
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
        
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        
        actionButton.configuration = .borderedTinted()
        actionButton.configuration?.cornerStyle = .medium
        actionButton.configuration?.baseBackgroundColor = .systemPink
        actionButton.configuration?.baseForegroundColor = .systemPink
        
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
}
