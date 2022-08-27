//
//  NoteDetailViewController.swift
//  LoginUI
//
//  Created by Macbook on 11/08/22.
//
import Foundation
import UIKit
import UserNotifications

class NoteDetailViewController: UIViewController {
    
    var descriptionTextView = UITextView()
    var selectNote: Notes? = nil
    var models = [Reminder]()
    let notificationsCenter = UNUserNotificationCenter.current()
    var archiveType = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationsCenter.requestAuthorization(options: [.alert, .sound]) {
            (permissionGranted, error) in
            if(!permissionGranted)
            {
                print("permission denied")
            }
        }
        view.backgroundColor = .white
        setUpConstraint()
        configureTextView()
        curdOperation()
        setdetail()
        
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Title"
        label.textAlignment = .center
        return label
    }()
    var titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .cyan
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
    
    func setdetail(){
        if selectNote != nil{
            titleTextField.text = selectNote?.title
            descriptionTextView.text = selectNote?.desc
        }
    }
    
    
    func setUpConstraint() {
        
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(titleTextField)
        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        titleLabel.leftAnchor.constraint(greaterThanOrEqualTo: view.leftAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(greaterThanOrEqualTo: view.rightAnchor, constant: -20).isActive = true
        
        titleTextField.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 30).isActive = true
        titleTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        titleTextField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleTextField.topAnchor, constant: 60).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        
    }
    
    func configureTextView()  {
        
        descriptionTextView.frame = CGRect(x: 20, y: 100, width: 200, height: 200)
        descriptionTextView.backgroundColor = .cyan
        
        view.addSubview(descriptionTextView)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: 30).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor).isActive = true
        descriptionTextView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        descriptionTextView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
    }
    func curdOperation(){
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(addNote))
        let deleteButton = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteNote))
        let reminderButton = UIBarButtonItem(image: UIImage(named: "bell"), style: .plain, target: self, action: #selector(tapRemainder))
        let archiveButton = UIBarButtonItem(image: UIImage(named: "archive"), style: .plain, target: self, action: #selector(tapArchive))
        navigationItem.rightBarButtonItems = [saveButton, deleteButton, reminderButton, archiveButton]
    }
    
    @objc func tapArchive(){
        print("tap on Archive")
        if archiveType == false {
            archiveType = true
        }
        else{
            archiveType = false
        }
    }
    
    @objc func tapRemainder(){
        print("tap on remainder")
        let vc  = ViewDatePicker()
        self.navigationController?.pushViewController(vc, animated: true)
        vc.completion = {date in
            print("enter in date completion")
            
            DispatchQueue.main.async {
                let new  = Reminder(date: date)
                self.models.append(new)
                self.notificationsCenter.getNotificationSettings {  (settings) in
                    
                    let content  = UNMutableNotificationContent()
                    content.title = self.selectNote?.title ?? "a"
                    content.body  =  self.selectNote?.desc ?? "b"
                    content.sound = .default
                    print("enter in notifations")
                    let targetDate = date
                    print(targetDate)
                    let dateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: targetDate)
                    print(date)
                    
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
                    
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    
                    self.notificationsCenter.add(request) { (error) in
                        if(error != nil)
                        {
                            print("Error " + error.debugDescription)
                            return
                        }
                    }
                }
                
            }
        }
    }
    
    @objc func deleteNote(){
        NoteService.connection.deleteNote(id: (selectNote?.id)!)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func addNote() {
        print("saving")
        if let inputText = titleTextField.text, !inputText.isEmpty && !descriptionTextView.text.isEmpty {
            guard let noteTitle = titleTextField.text,let noteDesc = descriptionTextView.text
            else {
                return
            }
            if selectNote != nil{
                self.updateSaveNote()
            }
            else {
                NoteService.connection.createNote(title: noteTitle, desc: noteDesc, archive: false) { err in
                    if  err != nil{
                        print("error in creating")
                    }
                    self.navigationController?.popViewController(animated: true)
                }
                
            }
        }
        
        else {
            openAlert(title: "Alert", message: "Please enter details", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in  }])
        }
        
    }
    
    func updateSaveNote(){
        if let inputText = titleTextField.text, !inputText.isEmpty && !descriptionTextView.text.isEmpty {
            guard let noteTitle = titleTextField.text,let noteDesc = descriptionTextView.text,
                  let noteId = selectNote?.id as? String
                    
            else {
                return
            }
            NoteService.connection.updateNote(id: noteId, title: noteTitle, desc: noteDesc, archiveType: archiveType) { error in
                if error != nil{
                    print("error")
                }
                self.navigationController?.popViewController(animated: true)
            }
            
        }
    }
    
}

struct Reminder {
    let date: Date
}
