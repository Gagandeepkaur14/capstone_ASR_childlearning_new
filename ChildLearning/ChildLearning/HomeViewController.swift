//
//  HomeViewController.swift
//  ChildLearning
//
//  Created by Rakinder on 11/04/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
