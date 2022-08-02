//
//  SignUpViewController.swift
//  LoginUI
//
//  Created by Macbook on 02/08/22.
//

import UIKit

class SignUpViewController: UITableViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func signUpButton(_ sender: Any) {
    }
    @IBAction func loginButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
