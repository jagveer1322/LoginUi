//
//  MenuOption.swift
//  LoginUI
//
//  Created by Macbook on 09/08/22

import UIKit

enum MenuOption: Int, CustomStringConvertible {
    case AppleKeep
    case Profile
    case Reminders
    case Archive
    case Settings
    case SignOut
    
    var description: String {
        switch self {
        case .AppleKeep: return ""
        case .Profile: return "Profile"
        case .Reminders: return "Reminders"
        case.Archive: return "Archive"
        case .Settings: return "Settings"
        case .SignOut: return "Sign out"
        }
    }
    
    var image: UIImage {
        switch self {
        case .Profile:
            return UIImage(named: "profile") ?? UIImage()
        case .Reminders:
            return UIImage(named: "bell") ?? UIImage()
        case.Archive:
            return UIImage(named: "archive") ?? UIImage()
        case .Settings:
            return UIImage(named: "settings") ?? UIImage()
        case .SignOut:
            return UIImage(named: "sign-out") ?? UIImage()
        case .AppleKeep:
            return UIImage(named: "apple-logo") ?? UIImage()
        }
    }
}
