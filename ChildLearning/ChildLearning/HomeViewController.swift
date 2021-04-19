//
//  HomeViewController.swift
//  ChildLearning
//
//  Created by Rakinder on 11/04/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet var btnsHome: [UIButton]!
    var strUserName = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in btnsHome{
            i.layer.cornerRadius = i.frame.size.height/2
            i.layer.borderWidth = 1
            i.layer.cornerRadius = i.frame.size.height/2
            i.layer.borderColor = UIColor.white.cgColor
        }
        lblUserName.text = strUserName
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func wordClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ButtonsViewController") as! ButtonsViewController
        vc.isWords = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func alphabetClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ButtonsViewController") as! ButtonsViewController
        vc.isAlphabets = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func numberClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ButtonsViewController") as! ButtonsViewController
        vc.isNumbers = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        let myalert = UIAlertController(title: "", message: "Are you sure you want to logout?", preferredStyle: UIAlertController.Style.alert)
        
        myalert.addAction(UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            self.logout()
        })
        myalert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
        })
        self.present(myalert, animated: true)
    }
    
    func logout(){
        UserDefaults.standard.removeObject(forKey: "username")
        if let vcs = self.navigationController?.viewControllers{
            for i in vcs{
                if i is ViewController{
                    self.navigationController?.popToViewController(i, animated: true)
                }
            }
        }
      
    }
}
