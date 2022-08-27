//
//  AppDelegate.swift
//  LoginUI
//
//  Created by Macbook on 30/07/22.
//

import UIKit

import FBSDKLoginKit
import Firebase
import GoogleSignIn
import FirebaseCore


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
//        window = UIWindow()
//        window?.makeKeyAndVisible()
//        window?.rootViewController = ContainerController()
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        FirebaseApp.configure()

        return true
    }
    func application(
                _ app: UIApplication,
                open url: URL,
                options: [UIApplication.OpenURLOptionsKey : Any] = [:]
            ) -> Bool {
                
                 ApplicationDelegate.shared.application(
                    app,
                    open: url,
                    sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                    annotation: options[UIApplication.OpenURLOptionsKey.annotation]
                )
                return GIDSignIn.sharedInstance.handle(url)
            }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

//enum UIDatePickerMode {
//        case Time, Date, DateAndTime, CountDownTimer
//    }
//
//    var remTitle = UITextField()
//    var remDesc = UITextField()
//    var datePicker = UIDatePicker()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemTeal
//        setupRemTitle()
//        setupRemDesc()
//        setupDatePicker()
//        configure()
//
//    }
//
//    func configure(){
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didtapSaveButton))
//    }
//
//    @objc func didtapSaveButton(){
//        if let titleText = remTitle.text , !titleText.isEmpty,
//           let descText = remDesc.text , !descText.isEmpty
//        {
//
//            let targetDate = datePicker.date
//
//
//        }
//
//    }
//
//    func setupRemTitle(){
//        view.addSubview(remTitle)
//        remTitle.translatesAutoresizingMaskIntoConstraints = false
//        remTitle.backgroundColor = .cyan
//        NSLayoutConstraint.activate([
//            remTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
//            remTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
//            remTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
//            remTitle.heightAnchor.constraint(equalToConstant: 52)
//        ])
//    }
//
//    func setupRemDesc(){
//        view.addSubview(remDesc)
//        remDesc.translatesAutoresizingMaskIntoConstraints = false
//        remDesc.backgroundColor = .cyan
//        NSLayoutConstraint.activate([
//            remDesc.topAnchor.constraint(equalTo: remTitle.bottomAnchor, constant: 20),
//            remDesc.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
//            remDesc.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
//            remDesc.heightAnchor.constraint(equalToConstant: 52)
//        ])
//    }
//
//    func setupDatePicker(){
//        datePicker = UIDatePicker(frame: CGRect(x: 0, y: 200, width: 300, height: 50))
//        datePicker.datePickerMode = .dateAndTime
//        view.addSubview(datePicker)
//
//    }
