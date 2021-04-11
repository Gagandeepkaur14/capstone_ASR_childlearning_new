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
                self.arr = list.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
                    self.collectionVWords.reloadData()
               }
        }
       
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
