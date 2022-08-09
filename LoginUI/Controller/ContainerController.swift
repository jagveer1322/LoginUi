//
//  ContainerController.swift
//  LoginUI
//
//  Created by Macbook on 06/08/22.
import UIKit

class ContainerController: UIViewController {
    
    var menuController : UIViewController!
    var centerController: UIViewController!
    var isExpanded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        view.backgroundColor = .brown
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
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
            print("configure home controller")
            
        }
        
    }
    func showMenuController(shouldExpand: Bool) {

        if shouldExpand {

            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {

                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80

            }, completion: nil)
        }
        else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = 0
            }, completion: nil)

        }
    }

}
extension ContainerController : HomeControllerDelegate{
    func handleMenuToggle() {
                if !isExpanded {
                    configureMenuController()
                }
                
                isExpanded = !isExpanded
                showMenuController(shouldExpand: isExpanded)
            }
    }
