//
//  MenuOption.swift
//  LoginUI
//
//  Created by Macbook on 09/08/22

import UIKit

enum MenuOption: Int, CustomStringConvertible {
    case AppleKeep
    case Profile
    case Notes
    case Settings
    case SignOut
    
    var description: String {
        switch self {
        case .AppleKeep: return ""
        case .Profile: return "Profile"
        case .Notes: return "Notes"
        case .Settings: return "Settings"
        case .SignOut: return "Sign out"
        }
    }
    
    var image: UIImage {
        switch self {
        case .Profile:
            return UIImage(named: "profile") ?? UIImage()
        case .Notes:
            return UIImage(named: "notes") ?? UIImage()
        case .Settings:
            return UIImage(named: "settings") ?? UIImage()
        case .SignOut:
            return UIImage(named: "sign-out") ?? UIImage()
        case .AppleKeep:
            return UIImage(named: "apple-logo") ?? UIImage()
        }
    }
}
