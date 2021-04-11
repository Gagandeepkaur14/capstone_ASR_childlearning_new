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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in btnsHome{
            i.layer.cornerRadius = i.frame.size.height/2
            i.layer.borderWidth = 1
            i.layer.cornerRadius = i.frame.size.height/2
            i.layer.borderColor = UIColor.white.cgColor
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func wordClicked(_ sender: Any) {
    }
    
    @IBAction func alphabetClicked(_ sender: Any) {
    }
    
    @IBAction func numberClicked(_ sender: Any) {
    }
    
    @IBAction func logoutClicked(_ sender: Any) {

    }

}
