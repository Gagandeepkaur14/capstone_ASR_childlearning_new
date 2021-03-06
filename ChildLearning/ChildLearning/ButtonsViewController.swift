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
    
    @IBOutlet weak var btnPlay: UIButton!
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
        btnPlay.layer.cornerRadius = 3.0
        if isNumbers{
           arr = Constant.appDelegate.arrNumber
            color = colorArray[2]
            lblTitle.title = "Numbers"
        }
        else if isAlphabets{
           arr = Constant.appDelegate.arrAlphabets
            color = colorArray[1]
            lblTitle.title = "Alphabets"
        }
        else{
           words = Constant.appDelegate.words
            color = colorArray[0]
            lblTitle.title = "Words"
        }
        lblTitle.tintColor = color
        imgTitle.tintColor = color
        collectionVWords.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func playClicked(_ sender: Any) {
        if #available(iOS 13.0, *) {
            let vc = self.storyboard?.instantiateViewController(identifier: "PlayViewController") as! PlayViewController
            vc.isWords = isWords
            vc.isNumber = isNumbers
            vc.isAlphabet = isAlphabets
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlayViewController") as! PlayViewController
            vc.isWords = isWords
            vc.isNumber = isNumbers
            vc.isAlphabet = isAlphabets
            self.navigationController?.pushViewController(vc, animated: true)
            // Fallback on earlier versions
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
            let word = Constant.appDelegate.words[indexPath.row]
            cell.imgV.sd_setImage(with: URL(string: word.Name), placeholderImage: nil)
        }
        else{
            cell.imgV.isHidden = true
            cell.lblName.text = arr[indexPath.row].capitalized
        }
      
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if #available(iOS 13.0, *) {
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
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SpeakViewController") as! SpeakViewController
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
}

extension ButtonsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: self.view.frame.width/2 - 20, height: self.view.frame.width/2 - 20)
       
    }
}
