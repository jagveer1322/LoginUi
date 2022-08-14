//
//  ListCell.swift
//  LoginUI
//
//  Created by Macbook on 11/08/22.
//

import UIKit

private let reuseIdentifier = "Cell"

class ListCell: UICollectionViewController {
   static let identifier = "ListCell"

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    let titleLabel: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        lable.lineBreakMode = .byWordWrapping
        lable.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        lable.text = "Hello"
        lable.textColor = .blue
        lable.textAlignment = .center
        return lable
    }()
    
    let descriptionLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        lable.lineBreakMode = .byWordWrapping
        lable.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        lable.text = "hi"
        return lable
    }()
    

}
