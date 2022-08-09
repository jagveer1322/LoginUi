//
//  MenuOptionCell.swift
//  LoginUI
//
//  Created by Macbook on 08/08/22.
//

import Foundation
import UIKit

class MenuOptionCell: UITableViewCell {
      
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .cyan
        return imageView
    }()
    
    let descriptionLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .black
        lable.font = UIFont.systemFont(ofSize: 16)
        lable.text = "Sample text"
        return lable
    }()
    
    // Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .systemMint
        addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 18).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        addSubview(descriptionLable)
        descriptionLable.translatesAutoresizingMaskIntoConstraints = false
        descriptionLable.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 12).isActive = true
        descriptionLable.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init code has not been implemented")
    }
}
