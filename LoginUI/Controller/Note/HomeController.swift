//
//  HomeController.swift
//  LoginUI
//
//  Created by Macbook on 06/08/22.
//
import UIKit


class HomeController : UIViewController{
 
    var delegate: HomeControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        configureNavigatiobBar()
    }
    @objc
    func handleMenuToggle(){
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    func configureNavigatiobBar(){
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.title = "HOME"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu-1"), style: .plain, target: self, action: #selector(handleMenuToggle))
    }
}
