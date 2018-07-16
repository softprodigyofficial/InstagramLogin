//
//  File.swift
//  InstragramLogin
//
//  Created by Administrator on 7/4/18.
//  Copyright © 2018 softprodigy. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

struct INSTAGRAM_IDS {
    
    static let AUTHURL = "https://api.instagram.com/oauth/authorize"
    static let APIURL = "https://api.instagram.com/v1/users"
    static let CLIENTID = "7cf1cfeed0d64aa0a67109a210ec6f73"
    static let CLIENTSECRET = "f3cbc77458174586a0bac8c990ee6d4d"
    static let REDIRECTURI = "https://www.softprodigy.com"
    static let ACCESSTOKEN = "access_token"
    static let SCOPE = "likes+comments+relationships"
    
}

let activityIndicator     = NVActivityIndicatorPresenter.sharedInstance
let activityData          = ActivityData()

func verifyUrl (urlString: String?) -> Bool {
    //Check for nil
    if let urlString = urlString {
        // create NSURL instance
        if let url = NSURL(string: urlString) {
            // check if your application can open the NSURL instance
            return UIApplication.shared.canOpenURL(url as URL)
        }
    }
    return false
}
