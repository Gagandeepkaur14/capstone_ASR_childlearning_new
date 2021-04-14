//
//  FirebaseModel.swift
//  ChildLearning
//
//

import UIKit
import FirebaseDatabase

struct Users {
    var name = ""
    var email = ""
    var id = ""
    var password = ""
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
       // self.id = id
         self.password = password
    }
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String:AnyObject]
        name = snapshotValue["name"] as? String ?? ""
        email = snapshotValue["email"] as? String ?? ""
        password = snapshotValue["password"] as? String ?? ""

    }
}

struct Words {
    var title = ""
    var Name = ""
    init(title: String, Name: String) {
        self.Name = Name
        self.title = title
    }
}
