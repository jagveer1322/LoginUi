//
//  MenuOption.swift
//  LoginUI
//
//  Created by Macbook on 09/08/22

import CoreText

enum MenuOption: Int, CustomStringConvertible{
    case profile
    case Notifications
    case Settings
    case SignOut
    
    var description: String{
        switch self{
        case .profile: return "Profile"
        case .Notifications: return "Notifications"
        case .Settings: return "Settings"
        case .SignOut: return "SignOut"
        }
}
}
