//
//  SignUpViewController.swift
//  LoginUI
//
//  Created by Macbook on 02/08/22.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UITableViewController {
    
    
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageProfile.addGestureRecognizer(tapGesture)
        
    }
    @objc
    func imageTapped(tapGestureRecognizer : UITapGestureRecognizer){
        print("Image Tapped")
        openGallery()
    }
    
    
    
    
    @IBAction func signUpButton(_ sender: UIButton) {
        let imgSystem = UIImage(systemName: "person.crop.circle.badge.plus")
        if imageProfile.image?.pngData() != imgSystem?.pngData(){
            
            if let username = usernameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, let confirmPassword = confirmPasswordTextField.text{
                if username == ""{
                    openAlert(title: "Alert", message: "Please enter username", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                    
                }else if !email.validateEmail(){
                    openAlert(title: "Alert", message: "Please enter valid email", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                    
                }else if !password.validatePassword(){
                    openAlert(title: "Alert", message: "Please enter valid password", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                    
                }else if confirmPassword == ""{
                    openAlert(title: "Alert", message: "Please enter confirm password", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                }else
                {
                    if password == confirmPassword{
                        Auth.auth().createUser(withEmail: email, password: password) { authresult, error in
                            if error != nil{
                                print("something went wrong")
                                return}
                        self.navigationController?.popViewController(animated: true)
                            }
    
                        }else{
                            openAlert(title: "Alert", message: "Please enter Same password", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                        }
                    }
                }else{
                    openAlert(title: "Alert", message: "Please check your details", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                }
            }else{
                print("Please select profile picture")
                openAlert(title: "Alert", message: "Please select profile picture", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
            }
        }
        
        
        @IBAction func loginButton(_ sender: Any) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    extension SignUpViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
        
        func openGallery(){
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = .savedPhotosAlbum
                present(picker, animated: true)
            }
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let img = info[.originalImage] as? UIImage{
                imageProfile.image = img
            }
            dismiss(animated: true)
        }
    }
    
