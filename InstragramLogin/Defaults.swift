//
//  Defaults.swift
//  Chnen
//
//  Created by user on 14/05/18.
//  Copyright © 2018 navjot_sharma. All rights reserved.
//

import UIKit

class Defaults {
    
    // device id
    
    static var save : Bool {
        get {
            return UserDefaults.standard.bool(forKey: "SavedStringArray")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "SavedStringArray")
        }
    }
    
}
