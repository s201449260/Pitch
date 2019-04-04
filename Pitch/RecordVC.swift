//
//  ViewController.swift
//  Pitch
//
//  Created by Abdullah alammar on 15/03/2019.
//  Copyright © 2019 Abdullah alammar. All rights reserved.
//

import UIKit
import AVFoundation

class RecordVC: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder : AVAudioRecorder!
    
    @IBOutlet weak var recordBtn: UIButton!
    
    @IBOutlet weak var recordLabel: UILabel!
    
    
    @IBOutlet weak var stopRecordBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func startRecord(_ sender: UIButton) {
        
//        recordLabel.text = "recording now..."
//        recordBtn.isEnabled = false
//        stopRecordBtn.isEnabled = true
        configureUI(recording: true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
        
    }
    
    @IBAction func stopRecord(_ sender: UIButton) {
        
//        recordLabel.text = "Tap to record"
//        recordBtn.isEnabled = true
//        stopRecordBtn.isEnabled = false

        configureUI(recording: false)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        

        
    }
    
    func configureUI(recording : DarwinBoolean) {
        
        if recording == true {
            
            recordLabel.text = "recording now..."
            recordBtn.isEnabled = false
            stopRecordBtn.isEnabled = true
            
        }
        
        else{
            
            recordLabel.text = "Tap to record"
            recordBtn.isEnabled = true
            stopRecordBtn.isEnabled = false
            
        }
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag : Bool) {
        
        if flag {
            
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else {
             print("bad recording")
        }
        
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "stopRecording"  {
            let playCV = segue.destination as! PlaySoundsViewController
            let recoredURL = sender as! URL
            playCV.recordedAudioURL = recoredURL
        }
        
    }
    
    
}

