//
//  AppDelegate.swift
//  ChildLearning
//
//

import UIKit
import IQKeyboardManagerSwift
import FBSDKCoreKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var arrAlphabets = [String]()
    var arrNumber = [String]()
    var words = [Words]()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        IQKeyboardManager.shared.enable = true
        FirebaseApp.configure()
        ApplicationDelegate.shared.application(
                   application,
                   didFinishLaunchingWithOptions: launchOptions
               )
        fetchAlphabets()
        fetchNumbers()
        // Override point for customization after application launch.
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

    func fetchAlphabets(){
        let db = Firestore.firestore()
        db.collection(Constant.FirebaseData.Alphabets).getDocuments { (query, error) in
            if let err = error {
                   print("Error getting documents: \(err)")
               } else {
                var list = [String]()
                   for document in query!.documents {
                       print("\(document.documentID) => \(document.data())")
                    if let doc = document.data() as? [String: Any]{
                        if let value =  doc["name"] as? String{
                            print("value ------ \(value)")
                            list.append(value)
                        }
                       
                    }
                   }
                self.arrAlphabets = list.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
               }
        }
       
    }
    
    
    func fetchNumbers(){
        let db = Firestore.firestore()
        print(db.collection(Constant.FirebaseData.Numbers))
        db.collection(Constant.FirebaseData.Numbers).getDocuments { (query, error) in
            if let err = error {
                   print("Error getting documents: \(err)")
               } else {
                var list = [String]()
                   for document in query!.documents {
                       print("\(document.documentID) => \(document.data())")
                    if let doc = document.data() as? [String: Any]{
                        if let value =  doc["name"] as? String{
                            print("value ------ \(value)")
                            list.append(value)
                        }
                       
                    }
                   }
                self.arrNumber = list.sorted {$0.localizedStandardCompare($1) == .orderedAscending}
               }
        }
       
    }
    
    func fetchWords(){
        let db = Firestore.firestore()
        db.collection(Constant.FirebaseData.Words).getDocuments { (query, error) in
            if let err = error {
                   print("Error getting documents: \(err)")
               } else {
                   for document in query!.documents {
                    if let doc = document.data() as? [String: Any]{
                        if let value =  doc["Name"] as? DocumentReference{
                            value.getDocument { (document, error) in
                                let storageRef = Storage.storage().reference(withPath: document?.documentID ?? "")
                                storageRef.downloadURL { url, error in
                                    let str1 = doc["title"] as? String ?? ""
                                    let word = Words(title: str1, Name:  url?.absoluteString ?? "")
                                    self.words.append(word)
                                }
                            }
                        }
                       
                    }
                   }
        }
    }
    
    

}

