//
//  ContainerController.swift
//  LoginUI
//
//  Created by Macbook on 06/08/22.
import UIKit
import FirebaseAuth
import GoogleSignIn

class ContainerController: UIViewController {
    
    var menuController : MenuController!
    var centerController: UIViewController!
    var isExpanded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        view.backgroundColor = .systemMint
        configureHomeController()
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
        return .slide
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    override var prefersStatusBarHidden: Bool{
        return isExpanded
    }
    
    func configureHomeController() {
      
        let homeController = HomeController()
        homeController.delegate = self
        centerController = UINavigationController(rootViewController: homeController)
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
        
    }
    func configureMenuController(){
        
        if menuController == nil {
            menuController = MenuController()
            menuController.delegate = self
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
        }
        
    }
    func showMenuController(shouldExpand: Bool, menuOption: MenuOption?) {
        
        if shouldExpand {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80
                
            }, completion: nil)
        }
        else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            }, completion: nil)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = 0
            }) { (_) in
                guard let menuOption = menuOption else { return }

                self.didSelectMenuOption(menuOption: menuOption)
            }
        }
    }
    
    func didSelectMenuOption(menuOption: MenuOption) {
        switch menuOption {
        case.AppleKeep:
            print("apple")
        case .Profile:
            print("profile")
        case .Notes:
            print("Notes")
        case .Settings:
            print("settings")
        case .SignOut:
            print("signout")
            signout()
        }
    }
    func signout(){
        
        let firebaseAuth = Auth.auth()
               do {
                   try firebaseAuth.signOut()
                   GIDSignIn.sharedInstance.signOut()
                   let scene = UIApplication.shared.connectedScenes.first
                   if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
                       let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                       if let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginTableViewController") as? LoginTableViewController{
                           print("hello")
                          openAlert(title: "Alert", message: "Successfully Sign Out ", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                           sd.window!.rootViewController = UINavigationController(rootViewController: loginVC)
                       }
                   }
               }
               catch let signOutError as NSError {
                   print("Error signing out: %@", signOutError)
               }
           }
}

extension ContainerController: HomeControllerDelegate {
    func handleMenuToggle(forMenuOption menuOption: MenuOption?) {
        if !isExpanded {
            configureMenuController()
        }
        isExpanded = !isExpanded
        showMenuController(shouldExpand: isExpanded, menuOption: menuOption)
    }
}
