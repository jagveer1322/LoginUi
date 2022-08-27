//
//  ViewDatePicker.swift
//  LoginUI
//
//  Created by Macbook on 23/08/22.
//

import Foundation
import UIKit

class ViewDatePicker: UIViewController {
    
    var datePicker = UIDatePicker()
    public var completion: ((Date)-> Void)?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        setupDatePicker()
        configureNavigation()
    }
    
    func configureNavigation(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didtapSaveButton))
    }
    
    func setupDatePicker(){
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels
        view.addSubview(datePicker)
        
    }
      
    @objc func didtapSaveButton(){
        
        print("set reminder")
        let targetdate = datePicker.date
        completion?(targetdate)
        self.navigationController?.popViewController(animated: true)
        
        //        notificationsCenter.getNotificationSettings {  (settings) in
        //
        //             DispatchQueue .main.async {
        //
        //             let date = self.datePicker.date
        //             if(settings.authorizationStatus == .authorized)
        //             {
        //                 let content  = UNMutableNotificationContent()
        //                 content.title = vcnote.self.selectNote?.title ?? "alpha1"
        //                 content.body  = vcnote.self.selectNote?.title ?? "beta"
        //                 content.sound = .default
        //
        //                 let dateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        //
        //                 let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
        //
        //                 let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        //
        //                 self.notificationsCenter.add(request) { (error) in
        //                     if(error != nil)
        //                     {
        //                         print("Error " + error.debugDescription)
        //                         return
        //                     }
        //                 }
        //                 let ac = UIAlertController(title: "Notifications Scheduled", message: "At" + self.formattedDate(date: date), preferredStyle: .alert)
        //                 ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in }))
        //                 self.present(ac, animated: true)
        //             }
        //             else{
        //                 let ac = UIAlertController(title: " Enable Notifications ?", message: "To use this feature you must enablenotifications in settings", preferredStyle: .alert)
        //                 let goToSettings = UIAlertAction(title: "Settings", style: .default)
        //                 { (_) in
        //                     guard let settingURL = URL(string: UIApplication.openSettingsURLString)
        //                     else {
        //                         return
        //                     }
        //                     if(UIApplication.shared.canOpenURL(settingURL))
        //                     {
        //                         UIApplication.shared.open(settingURL) { (_) in }
        //                     }
        //                 }
        //                 ac.addAction(goToSettings)
        //                 ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in }))
        //                 self.present(ac, animated: true)
        //
        //            }
        //             }
        //         }
        //
        //     }
        //
        //     func formattedDate(date: Date) -> String{
        //
        //         let formatter = DateFormatter()
        //         formatter.dateFormat = "d MMM y HH:mm"
        //         return formatter.string(from: date)
        //     }
    }
    
}


