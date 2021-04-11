//
//  SignUpViewController.swift
//  ChildLearning
//
//

import UIKit
import FirebaseDatabase

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var txtFEmail: UITextField!
    @IBOutlet weak var txtFPassword: UITextField!
    var ref: DatabaseReference!
    var users: [Users] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        fetchAllUsers()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = true
        // Do any additional setup after loading the view.
    }
    
    func fetchAllUsers(){
        /*
         Get the all data from Firebase
         */
        ref.child(Constant.FirebaseData.User).observe(.value, with: { snapshot in
       
            for eachPlace in (snapshot.children){
                let place = Users(snapshot: eachPlace as! DataSnapshot)
                self.users.append(place)
                
            }
           
        })
    }
    
    func signupObserverFirebase(email: String,name: String, password: String){ 
        let data = ["name": name,
                    "email": email,
                    "password" : password] as [String : Any]
        
        if users.contains(where: {$0.email == email }){
            Alert.addAlertController(strTittle: "", strMessage: "Email alreday registered", viewC: self)
        }
        else{
            ref.child(Constant.FirebaseData.User).childByAutoId().setValue(data)
            let vc = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
