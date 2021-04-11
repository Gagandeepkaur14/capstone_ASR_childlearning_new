//
//  LoginViewController.swift
//  ChildLearning
//
//  Created by Rakinder on 11/04/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var txtFPassword: UITextField!
    @IBOutlet weak var txtFEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
