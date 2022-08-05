//
//  TableViewController.swift
//  LoginUI
//
//  Created by Macbook on 01/08/22.
//

import UIKit
import FirebaseAuth
import Firebase
import FBSDKLoginKit
import GoogleSignIn

class LoginTableViewController: UITableViewController {
    
    
    @IBOutlet weak var facebookButton: FBLoginButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func gooleLogin(_ sender: UIButton) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in

          if let error = error {
            return
          }

          guard
            let authentication = user?.authentication,
            let idToken = authentication.idToken
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: authentication.accessToken)

          // ...
        }
    }
    @IBAction func fbButtonTapped(_ sender: UIButton) {
        let fbLoginVC = FBLoginVC()
        self.navigationController?.pushViewController(fbLoginVC, animated: true)
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
                    
                }])
            }else if !password.validatePassword(){
                openAlert(title: "Alert", message: "Please enter valid password", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    
                }])
                
            }
            
            else {      Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
                
                if err != nil {
                    
                    self.openAlert(title: "Alert", message: "Login Detail not match", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                } else {
                    print(" success")
                }
            }
            }
        }
    }
}
