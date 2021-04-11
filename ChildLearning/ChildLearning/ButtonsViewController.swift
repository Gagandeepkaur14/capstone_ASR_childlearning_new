//
//  ButtonsViewController.swift
//  ChildLearning
//
//  Created by Rakinder on 11/04/21.
//

import UIKit

class ButtonsViewController: UIViewController {

    @IBOutlet weak var collectionVWords: UICollectionView!
    var isAlphabets = Bool()
    var isNumbers = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

extension ButtonsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCollectionViewCell", for: indexPath) as! ButtonCollectionViewCell
        cell.layer.cornerRadius = 5.0
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: "SpeakViewController") as! SpeakViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ButtonsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: self.view.frame.width/2 - 20, height: self.view.frame.width/2 - 20)
       
    }
}
