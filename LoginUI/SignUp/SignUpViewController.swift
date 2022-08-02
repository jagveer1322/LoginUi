//
//  SignUpViewController.swift
//  LoginUI
//
//  Created by Macbook on 02/08/22.
//

import UIKit

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
                }
                else if !email.validateEmail(){
                    openAlert(title: "Alert", message: "Please enter valid email", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                    print("email is not valid")
                }else if !password.validatePassword(){
                    print("Password is not valid")
                } else
                if confirmPassword == ""{
                    print("Please confirm password")
                }else{
                    if password == confirmPassword{
                        
                        print("!")
                    }else{
                        print("password does not match")
                    }
                }
            }else{
                print("Please check your details")
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

