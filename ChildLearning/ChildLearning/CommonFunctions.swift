//
//  CommonFunctions.swift
//  ChildLearning
//
//  Created by Rakinder on 11/04/21.
//

import UIKit

class CommonFunctions: NSObject {
    static func isValidEmail(testStr:String) -> Bool {
         let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
         let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
         return emailTest.evaluate(with: testStr)
     }
}
