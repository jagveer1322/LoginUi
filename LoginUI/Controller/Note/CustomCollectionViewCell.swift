//
//  CustomCollectionViewController.swift
//  LoginUI
//
//  Created by Macbook on 12/08/22.
//

import Foundation
import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CusomCollectionViewCell"
    
    let titlelabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .cyan
        label.text = "hello"
        return label
    }()
    
    let desc: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "fhg"
        return label
    }()
    
    public func configure(titleLabel: String, descLabel: String ){
        titlelabel.text = titleLabel
       desc.text = descLabel
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titlelabel)
        contentView.addSubview(desc)
        contentView.layer.cornerRadius = 15
        contentView.layer.borderWidth = 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titlelabel.frame = CGRect(x: 5, y: 0, width: contentView.frame.size.width-10, height: 50)
        desc.frame = CGRect(x: 5, y: 50, width: contentView.frame.size.width-10, height: contentView.frame.height - 50)
    }
    
    
}
