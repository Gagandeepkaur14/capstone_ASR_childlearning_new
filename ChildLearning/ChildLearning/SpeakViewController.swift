//
//  SpeakViewController.swift
//  ChildLearning
//

import UIKit
import AVFoundation

class SpeakViewController: UIViewController {
    @IBOutlet weak var lblTitle: UIBarButtonItem!
    
    var strWord = String()
    var synthesizer = AVSpeechSynthesizer()
    @IBOutlet weak var lblName: UILabel!
    var utterance = AVSpeechUtterance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblName.text = strWord
        synthesizer = AVSpeechSynthesizer()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func textToSpeech(){
            utterance = AVSpeechUtterance(string: strWord)
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
                utterance = AVSpeechUtterance(string: strWord)
                utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                self.utterance.rate = 0.25
                synthesizer.speak(utterance)
            }
        }
}

extension SpeakViewController: AVSpeechSynthesizerDelegate{
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("Done ------- ")
        self.navigationController?.popViewController(animated: true)
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


