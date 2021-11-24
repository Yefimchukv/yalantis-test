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
    private let networkImage = UIImageView(image: UIImage(systemName: "wifi"))
    
    private let padding: CGFloat = 16
    
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
    
    func set(messageTitle: String, message: String, dateTitle: String) {
        self.titleLabel.text = messageTitle + "1"
        self.messageLabel.text = message
        self.dateLabel.text = dateTitle
        
    }
    //UIImage(systemName: "wifi")
    func configure() {
        backgroundColor = .systemGray6
        layer.cornerRadius = 10
        
        networkImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(networkImage, titleLabel, messageLabel, dateLabel)
    }
    
    func configureImage() {
        networkImage.clipsToBounds = true
        NSLayoutConstraint.activate([
            networkImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            networkImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
//            networkImage.heightAnchor.constraint(equalToConstant: 32),
//            networkImage.widthAnchor.constraint(equalToConstant: 32),
        ])
    }
    
    func configureTitle() {
        titleLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: 16
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 16
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -16
            ),
            titleLabel.heightAnchor.constraint(
                equalToConstant: 32
            )
        ])
    }

    func configureDate() {
        dateLabel.textAlignment = .center
        NSLayoutConstraint.activate([
            dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            dateLabel.heightAnchor.constraint(equalToConstant: 14),
            
        ])
    }
    
    func configureMessage() {
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 8
            ),
            messageLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 8
            ),
            messageLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -8
            ),
            messageLabel.bottomAnchor.constraint(
                equalTo: dateLabel.topAnchor,
                constant: -8)
        ])
    }
}
