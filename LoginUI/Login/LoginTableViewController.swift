//
//  TableViewController.swift
//  LoginUI
//
//  Created by Macbook on 01/08/22.
//

import UIKit

class LoginTableViewController: UITableViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
   
    @IBAction func signupButton(_ sender: UIButton) {
        
        if let signupVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController{
                    self.navigationController?.pushViewController(signupVC, animated: true)
                }
     print("hhhhhh")
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text{
                
            if !email.validateEmail(){
                openAlert(title: "Alert", message: "Please enter valid email.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                }])
            }else if !password.validatePassword(){
                openAlert(title: "Alert", message: "Please enter valid password", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                }])
            }
        }
    
        else{
            openAlert(title: "Alert", message: "Please add detail.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Okay clicked!")
            }])
        }
    }
    
}
