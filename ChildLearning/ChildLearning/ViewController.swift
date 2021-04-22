//
//  ViewController.swift
//  ChildLearning
//
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        btnLogin.layer.cornerRadius = btnLogin.frame.size.height/2
        btnSignUp.layer.borderWidth = 1
        btnSignUp.layer.cornerRadius = btnSignUp.frame.size.height/2
        btnSignUp.layer.borderColor = UIColor.white.cgColor
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        if #available(iOS 13.0, *) {
            let vc = self.storyboard?.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        
        if #available(iOS 13.0, *) {
            let vc = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }

}

