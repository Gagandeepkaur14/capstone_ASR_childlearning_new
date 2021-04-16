//
//  PlayViewController.swift
//  ChildLearning
//
//  Created by Rakinder on 16/04/21.
//

import UIKit
import AVFoundation

class PlayViewController: UIViewController {
    
    @IBOutlet weak var collectionVPlay: UICollectionView!
    
    var arr = [String]()
    var isWords = Bool()
    var isNumber = Bool()
    var isAlphabet = Bool()
    var arrFinal = [String]()
    var synthesizer = AVSpeechSynthesizer()
    var utterance = AVSpeechUtterance()
    var indexFinal = Int()
    var player = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        synthesizer = AVSpeechSynthesizer()
        synthesizer.delegate = self
        
        if isWords{
            
        }
        else if isNumber{
            arr = Constant.appDelegate.arrNumber
        }
        else{
            arr = Constant.appDelegate.arrAlphabets
        }
        var resultSet = Set<String>()
        var resultSetFinal = Set<String>()

        while resultSet.count < 4 {
            let randomIndex = Int(arc4random_uniform(UInt32(arr.count)))
            resultSet.insert(arr[randomIndex])
        }
        arrFinal = Array(resultSet)
        print(arrFinal)
        
        while resultSetFinal.count < 1 {
            let randomIndex = Int(arc4random_uniform(UInt32(arrFinal.count)))
            resultSetFinal.insert(arrFinal[randomIndex])
        }
        print("result ----- \(Array(resultSetFinal))")
        let arrSingle = Array(resultSetFinal)
        if arrSingle.count > 0{
            let str = arrSingle[0]
            indexFinal = arrFinal.lastIndex(of: str) ?? 0
            print("index -------- \(indexFinal)")
            textToSpeech(str: "Where is \(str)")
            
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func textToSpeech(str: String){
            utterance = AVSpeechUtterance(string: str)
            utterance.voice = AVSpeechSynthesisVoice(language:  "en-US") //BCP-47
       
            if (synthesizer.isPaused) {
                print("continueSpeaking ---------")
            //    updateNowPlaying(isPause: false)
                synthesizer.continueSpeaking();
            }
                // The pause functionality
            else if (synthesizer.isSpeaking) {
                print("pausedddddddd")
                synthesizer.pauseSpeaking(at: AVSpeechBoundary.immediate)
            }
                // The start functionality
            else if (!synthesizer.isSpeaking) {
                // Getting text to read from the UITextView (textView).
                utterance = AVSpeechUtterance(string: str)
                utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                self.utterance.rate = 0.3
                synthesizer.speak(utterance)
            }
        }

}


extension PlayViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrFinal.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCollectionViewCell", for: indexPath) as! ButtonCollectionViewCell
        if isWords{
            cell.imgV.isHidden = false
//            let word = words[indexPath.row]
//            cell.imgV.sd_setImage(with: URL(string: word.Name), placeholderImage: nil)
        }
        else{
            cell.imgV.isHidden = true
            cell.lblName.text = arrFinal[indexPath.row].capitalized
        }
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if  indexFinal == indexPath.row{
            playClap()
        }
        else{
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
    }
    
    func playClap(){
        let path = Bundle.main.path(forResource: "applause", ofType : "mp3")!
           let url = URL(fileURLWithPath : path)
           do {
               player = try AVAudioPlayer(contentsOf: url)
               player.play()
           } catch {
               print ("There is an issue with this code!")
           }
    }
}

extension PlayViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: self.view.frame.width/2 - 20, height: self.view.frame.width/2 - 20)
       
    }
}

extension PlayViewController: AVSpeechSynthesizerDelegate{
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("Done ------- ")
      //  self.navigationController?.popViewController(animated: true)
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
    }
    
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        self.utterance.rate = utterance.rate
      //  synthesizer.speak(utterance)
        
    }
}
