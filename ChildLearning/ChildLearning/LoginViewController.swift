//
//  LoginViewController.swift
//  ChildLearning
//
//

import UIKit
import FBSDKLoginKit
import FirebaseDatabase
import Firebase
import FirebaseFirestore

class LoginViewController: UIViewController {

    @IBOutlet weak var txtFPassword: UITextField!
    @IBOutlet weak var txtFEmail: UITextField!
    var ref: DatabaseReference!
    var users: [Users] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.ref = Database.database().reference()
        fetchAllUsers()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func facebookLoginClicked(_ sender: Any) {
        loginWithFb()
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        if txtFEmail.text == ""{
            Alert.addAlertController(strTittle: "", strMessage: "Please add the name ", viewC: self)
        }
        else  if txtFPassword.text?.count == 0{
            Alert.addAlertController(strTittle: "", strMessage: "Please add the password ", viewC: self)
        }
        else if !CommonFunctions.isValidEmail(testStr: txtFEmail.text ?? ""){
            Alert.addAlertController(strTittle: "", strMessage: "Please add valid email", viewC: self)
        }
        else{
            fetchLogin(email: txtFEmail.text ?? "", password: txtFPassword.text  ?? "")
        }
    }
    
    func fetchLogin(email: String, password: String){
        if let singleUser = users.enumerated().first(where: {$0.element.email == email}) {
            let user = singleUser.element
            if user.password != password{
                Alert.addAlertController(strTittle: "Error!", strMessage: "Incorrect Password", viewC: self)
            }
            else{
                
                if #available(iOS 13.0, *) {
                    let vc = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                    vc.strUserName = user.name
                    UserDefaults.standard.setValue(user.name, forKey: "username")
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    vc.strUserName = user.name
                    UserDefaults.standard.setValue(user.name, forKey: "username")
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        else{
            Alert.addAlertController(strTittle: "Error!", strMessage: "Email not registered", viewC: self)
        }
        
    }
    
    func fetchFbLogin(email: String){

        if let singleUser = users.enumerated().first(where: {$0.element.email == email}) {

            let user = singleUser.element
            if user.password == "facebook"{
                if #available(iOS 13.0, *) {
                    let vc = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                    vc.strUserName = user.name
                    UserDefaults.standard.setValue(user.name, forKey: "username")
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    vc.strUserName = user.name
                    UserDefaults.standard.setValue(user.name, forKey: "username")
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            else{
                Alert.addAlertController(strTittle: "Error!", strMessage: "User not registered with facebook", viewC: self)
            }
               
        }

        
    }
    
    func signupObserverFirebase(email: String,name: String){
        let data = ["name": name,
                    "email": email,
                    "password" : "facebook"] as [String : Any]
        
        if users.contains(where: {$0.email == email }){
            fetchFbLogin(email: email)
        }
        else{
            ref.child(Constant.FirebaseData.User).childByAutoId().setValue(data)
            if #available(iOS 13.0, *) {
                let vc = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                vc.strUserName = name
                UserDefaults.standard.setValue(name, forKey: "username")
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                vc.strUserName = name
                UserDefaults.standard.setValue(name, forKey: "username")
                self.navigationController?.pushViewController(vc, animated: true)
            }
           
        }
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

    func loginWithFb(){
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["email"], from: self) { (result, error) in
            if result?.grantedPermissions.contains("email") ?? false{
                self.getFBUserData()
                loginManager.logOut()
            }
            else if result?.isCancelled ?? false{
                print("User cancelled login.")
            }
        }
    }
    
    func getFBUserData(){
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    if  let dict = result as? [String : Any]{
                        self.signupObserverFirebase(email: dict["email"] as? String ?? "", name: dict["name"] as? String ?? "")
                    }
                }
            })
        }
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
