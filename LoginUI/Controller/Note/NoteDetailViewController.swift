//
//  NoteDetailViewController.swift
//  LoginUI
//
//  Created by Macbook on 11/08/22.
//

import UIKit

class NoteDetailViewController: UIViewController {
    
    let descriptionTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        setUpConstraint()
        configureTextView()
        saveNote()
        
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Title"
        label.textAlignment = .center
        return label
    }()
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.placeholder = "Type title here"
        return textField
    }()
    
    let descriptionLabel: UILabel = {
        let desLabel = UILabel()
        desLabel.translatesAutoresizingMaskIntoConstraints = false
        desLabel.numberOfLines = 0
        desLabel.text = "Description"
       
        desLabel.textAlignment = .center
        return desLabel
    }()
    
    
    func setUpConstraint() {
        
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(titleTextField)
        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        titleLabel.leftAnchor.constraint(greaterThanOrEqualTo: view.leftAnchor, constant: 50).isActive = true
        titleLabel.rightAnchor.constraint(greaterThanOrEqualTo: view.rightAnchor, constant: -30).isActive = true
        
        titleTextField.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 30).isActive = true
        titleTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        titleTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleTextField.topAnchor, constant: 60).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        
    }
    
    
    func configureTextView()  {
        
        descriptionTextView.frame = CGRect(x: 20, y: 100, width: 200, height: 200)
        descriptionTextView.backgroundColor = .white
        
        view.addSubview(descriptionTextView)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: 30).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor).isActive = true
        descriptionTextView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        descriptionTextView.widthAnchor.constraint(equalToConstant: 450).isActive = true
        
    }
    func saveNote(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(addNote))
    }
    @objc
    func addNote() {
        print("saving")
        if let inputText = titleTextField.text, !inputText.isEmpty && !descriptionTextView.text.isEmpty {
            guard let noteTitle = titleTextField.text,let noteDesc = descriptionTextView.text
            else {
                return
            }
            NoteService.connection.createNote(title: noteTitle, describe: noteDesc)
                                    self.navigationController?.popViewController(animated: true)
                        
            }
        else {
                openAlert(title: "Alert", message: "Please enter details", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in  }])
        }
            
    }
}
