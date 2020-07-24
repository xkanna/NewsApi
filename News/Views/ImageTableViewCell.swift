//
//  ImageTableViewCell.swift
//  News
//
//  Created by Katarina Veljkovic on 22/07/2020.
//  Copyright © 2020 Katarina Veljkovic. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

   var imageUI = UIImageView()
    var headlineTitleLabel = UILabel()
    var headerTopConstraint: NSLayoutConstraint!
    var headerHeightConstraint: NSLayoutConstraint!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI(){
        
        contentView.addSubview(imageUI)
        imageUI.translatesAutoresizingMaskIntoConstraints = false
        imageUI.contentMode = .scaleAspectFit
        headerHeightConstraint = imageUI.heightAnchor.constraint(equalToConstant: 210)
        headerHeightConstraint.isActive = true
        imageUI.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.0).isActive = true
        headerTopConstraint = imageUI.topAnchor.constraint(equalTo: contentView.topAnchor)
        headerTopConstraint.isActive = true
        imageUI.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        let constraint = imageUI.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        constraint.priority = UILayoutPriority(rawValue: 999)
        constraint.isActive = true
        imageUI.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageUI.clipsToBounds = true
        
        contentView.addSubview(headlineTitleLabel)
        headlineTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        headlineTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 130).isActive = true
        headlineTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        headlineTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        headlineTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        headlineTitleLabel.textAlignment = .center
        headlineTitleLabel.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        headlineTitleLabel.textColor = .black
        headlineTitleLabel.numberOfLines = 2
    }
}

