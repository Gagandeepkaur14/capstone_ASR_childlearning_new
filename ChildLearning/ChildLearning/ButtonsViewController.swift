//
//  ButtonsViewController.swift
//  ChildLearning
//
//  Created by Rakinder on 11/04/21.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import SDWebImage



class ButtonsViewController: UIViewController {
    @IBOutlet weak var lblTitle: UIBarButtonItem!
    @IBOutlet weak var imgTitle: UIBarButtonItem!
    @IBOutlet weak var collectionVWords: UICollectionView!
    var arr = [String]()
    var isNumbers = Bool()
    var isAlphabets = Bool()
    var isWords = Bool()
    var words = [Words]()
    var colorArray: [UIColor] = [UIColor(red: 116/255, green: 29/255, blue: 149/255, alpha: 1.0),
                      UIColor(red: 255/255, green: 202/255, blue: 0/255, alpha: 1.0),
                      UIColor(red: 255/255, green: 114/255, blue: 0/255, alpha: 1.0),
                      UIColor(red: 116/255, green: 202/255, blue: 0/255, alpha: 1.0),]
    
    var color = UIColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isNumbers{
            fetchNumbers()
            color = colorArray[2]
            lblTitle.title = "Numbers"
            
            
        }
        else if isAlphabets{
            fetchAlphabets()
            color = colorArray[1]
            lblTitle.title = "Alphabets"
        }
        else{
            fetchWords()
            color = colorArray[0]
            lblTitle.title = "Words"
        }
        lblTitle.tintColor = color
        imgTitle.tintColor = color
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func playClicked(_ sender: Any) {
        
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
                self.arr = list.sorted {$0.localizedStandardCompare($1) == .orderedAscending}
                self.collectionVWords.reloadData()
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
                                    self.collectionVWords.reloadData()
                                }
                            }
                        }
                       
                    }
                   }
                print(self.words)
                    self.collectionVWords.reloadData()
               }
        }
    }
    

}

extension ButtonsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isWords{
            return words.count
        }
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCollectionViewCell", for: indexPath) as! ButtonCollectionViewCell
        cell.backgroundColor = color
        cell.layer.cornerRadius = 5.0
        if isWords{
            cell.imgV.isHidden = false
            let word = words[indexPath.row]
            cell.imgV.sd_setImage(with: URL(string: word.Name), placeholderImage: nil)
        }
        else{
            cell.imgV.isHidden = true
            cell.lblName.text = arr[indexPath.row].capitalized
        }
      
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: "SpeakViewController") as! SpeakViewController
        vc.isWord = isWords
        vc.isAlphabets = isAlphabets
        vc.isNumbers = isNumbers
        if isWords{
            vc.strWord = words[indexPath.row].title
            vc.isWord = true
            vc.word = words[indexPath.row]
        }
        else{
            vc.strWord = arr[indexPath.row]
        }
      
      
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ButtonsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: self.view.frame.width/2 - 20, height: self.view.frame.width/2 - 20)
       
    }
}
