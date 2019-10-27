//
//  Messages.swift
//  Go(Mahendra)
//
//  Created by Mahendra Vishwakarma on 26/10/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import Foundation

class Messages{
    static let base_url = "http://gojek-contacts-app.herokuapp.com"
    static let contact_url = "http://gojek-contacts-app.herokuapp.com/contacts.json"
}

class Utils {
    class func checkEmail(_ email:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if !emailTest.evaluate(with: email) {
            
            return false
        }
        
        return true
    }
}
