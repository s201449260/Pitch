//
//  PlayVC.swift
//  Pitch
//
//  Created by Abdullah alammar on 15/03/2019.
//  Copyright © 2019 Abdullah alammar. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }


    @IBOutlet weak var FastBtn: UIButton!
    
    @IBOutlet weak var SlowBtn: UIButton!
    
    @IBOutlet weak var LowPitchBtn: UIButton!
    
    @IBOutlet weak var HighPitchBtn: UIButton!
    
    @IBOutlet weak var ReverbBtn: UIButton!
    
    @IBOutlet weak var EchoBtn: UIButton!
    
    @IBOutlet weak var StopBtn: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func play(_ sender: UIButton) {
        print("playing")
        
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    
    
    @IBAction func stop(_ sender: UIButton) {
        
        print("stopped")
        stopAudio()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
