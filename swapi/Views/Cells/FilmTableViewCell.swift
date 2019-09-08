//
//  FilmTableViewCell.swift
//  swapi
//
//  Created by Nicolas Desormiere on 9/9/19.
//  Copyright © 2019 Nicolas Desormiere. All rights reserved.
//

import UIKit

class FilmTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let directorLabel = UILabel()
    let producerLabel = UILabel()
    let releaseDateLabel = UILabel()
    let shadowContainerView = UIView()
    let containerView = UIView()
    let containerStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        selectionStyle = .none
        backgroundColor = .clear

        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        
        shadowContainerView.layer.shadowColor = UIColor.lightGray.cgColor
        shadowContainerView.layer.shadowRadius = 3
        shadowContainerView.layer.shadowOpacity = 0.30
        shadowContainerView.layer.shadowOffset = CGSize(width: 0, height: 5)
        
        containerStackView.axis = .vertical
        containerStackView.distribution = .fill
        containerStackView.alignment = .fill
        containerStackView.spacing = 5
        containerStackView.addArrangedSubviews([titleLabel, directorLabel, producerLabel, releaseDateLabel])
        
        containerView.addSubviews(containerStackView)
        shadowContainerView.addSubviews(containerView)
        containerView.fillSuperview()
        addSubviews(shadowContainerView)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            containerStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            containerStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            containerStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            ])
    }
}
