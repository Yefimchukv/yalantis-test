//
//  HistoryItemCell.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 24.11.2021.
//

import UIKit

class HistoryItemCell: UICollectionViewCell {
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let dateLabel = UILabel()
    private let networkImage = UIImageView()
    
    private let padding: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureImage()
        configureTitle()
        configureDate()
        configureMessage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(isLocal: Bool, messageTitle: String, message: String, dateTitle: String) {        
        self.networkImage.image = isLocal ? UIImage(systemName: "wifi.slash") : UIImage(systemName: "wifi")
        self.titleLabel.text = messageTitle
        self.messageLabel.text = message
        self.dateLabel.text = dateTitle
    }
}

// MARK: - Private configures and constraints
private extension HistoryItemCell {
    
    func configure() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 10
        
        networkImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(networkImage, titleLabel, messageLabel, dateLabel)
    }
    
    func configureImage() {
        networkImage.tintColor = .systemRed
        
        NSLayoutConstraint.activate([
            networkImage.topAnchor.constraint(equalTo: self.topAnchor, constant: padding * 2),
            networkImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding * 2)
        ])
    }
    
    func configureTitle() {
        titleLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: padding * 2
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: padding * 2
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -padding * 2
            ),
            titleLabel.heightAnchor.constraint(
                equalToConstant: 32
            )
        ])
    }

    func configureDate() {
        dateLabel.textAlignment = .center
        NSLayoutConstraint.activate([
            dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 14)
        ])
    }
    
    func configureMessage() {
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: padding
            ),
            messageLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: padding
            ),
            messageLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -padding
            ),
            messageLabel.bottomAnchor.constraint(
                equalTo: dateLabel.topAnchor,
                constant: -padding)
        ])
    }
}
