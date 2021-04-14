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

    @IBOutlet weak var collectionVWords: UICollectionView!
    var arr = [String]()
    var isNumbers = Bool()
    var isAlphabets = Bool()
    var isWords = Bool()
    var words = [Words]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isNumbers{
            fetchNumbers()
        }
        else if isAlphabets{
            fetchAlphabets()
        }
        else{
            fetchWords()
        }
       
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
                var list = [String]()
               
                var strTitle = String()
                   for document in query!.documents {
                       print("\(document.documentID) => \(document.data())")
                    if let doc = document.data() as? [String: Any]{
                       if let str =  doc["title"] as? String{
                       strTitle = str
                        }
                        if let value =  doc["Name"] as? DocumentReference{
                            print("value ------ \(value)")
                            value.getDocument { (document, error) in
                                print("document ------ \(document?.metadata)")
                                print("document id------ \(document?.documentID)")
                                let storageRef = Storage.storage().reference(withPath: document?.documentID ?? "")
                                let url = (Storage.storage().reference(forURL: storageRef.description))
                               // self.imgV.sd_setImage(with: url, placeholderImage: nil)
                                print(Storage.storage().reference(forURL: storageRef.description))
                                
                                storageRef.downloadURL { url, error in
                                    print("url ----- \(url)")
                                    let word = Words(title: strTitle, Name:  url?.absoluteString ?? "")
                                    self.words.append(word)
                                    print("error ----- \(error)")
                                  if let error = error {
                                    // Handle any errors
                                    
                                  } else {
                                    // Get the download URL for 'images/stars.jpg'
                                  }
                                }
                                
                                let reference = storageRef.child("images/stars.jpg")
                                
                            }
                            
                            
                          //  list.append(value)
                        }
                       
                    }
                   }
                print(self.words)
              //  print(words[0].Name)
                self.arr = list.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
                    self.collectionVWords.reloadData()
               }
        }
        db.collection(Constant.FirebaseData.Words).addSnapshotListener(includeMetadataChanges: true) { (query, error) in
            print("query ===== \(query)")
            guard let query = query else {
                if let error = error {
                    print("error getting images: ", error.localizedDescription)
                }
                return
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
        vc.strWord = arr[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ButtonsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: self.view.frame.width/2 - 20, height: self.view.frame.width/2 - 20)
       
    }
}
