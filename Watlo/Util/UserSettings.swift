//
//  UserSettings.swift
//  Watlo
//
//  Created by Mostafa Alaa on 8/16/18.
//  Copyright © 2018 Mostafa Alaa. All rights reserved.
//

import Foundation

class UserSettings{
    
    private let defaults = UserDefaults.standard
    static let instance = UserSettings()
    private init(){
        
    }
    var dailyAmount : String?{
        get{
            return defaults.string(forKey: "dailyAmount")
        }
        set{
            defaults.set(newValue!, forKey: "dailyAmount")
        }
    }
    var favTime : String?{
        get{
            return defaults.string(forKey: "favTime")
        }
        set{
            defaults.set(newValue!, forKey: "favTime")
        }
    }
    var currentPage : Int? {
        get{
            return defaults.integer(forKey: "currentPage")
        }
        set{
            defaults.set(newValue!, forKey: "currentPage")
        }
    }
    var khatmaType : Bool?{
        get {
            return defaults.bool(forKey: "khatmaType")
        }
        set{
            defaults.set(newValue!, forKey: "khatmaType")
        }
    }
    var lastDay : Int?{
        get{
            return defaults.integer(forKey: "lastDay")
        }
        set{
            defaults.set(newValue!, forKey: "lastDay")
        }
    }
}
