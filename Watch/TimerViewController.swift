//
//  TimerViewController.swift
//  Watch
//
//  Created by Mihael Matyatsko on 25.06.2021.
//

import UIKit
import AVFoundation

class TimerViewController: UIViewController {

    var timer = Timer()
    var isCounting : Bool = false
    var isSilenceMode: Bool = false
    var timerNumber: Int = 0
    var player = AVAudioPlayer()
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var downView: UIView!
    
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var silenceButton: UIButton!
    @IBOutlet weak var startTimerButton: UIButton!
    @IBOutlet weak var pauseTimerButton: UIButton!
    @IBOutlet weak var timerPicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerPicker.datePickerMode = .countDownTimer
        startTimerButton.layer.cornerRadius = 0.5 * startTimerButton.bounds.size.width
        pauseTimerButton.layer.cornerRadius = 0.5 * pauseTimerButton.bounds.size.width
        
        topView.layer.borderWidth = 0.5
        topView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        
        notificationLabel.isHidden = true
    }
    
    @IBAction func startCountDown(_ sender: UIButton) {
        if isCounting == false{
            isCounting = true
            timerNumber = Int(timerPicker.countDownDuration)
            timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(countDown(param:)), userInfo: nil, repeats: true)
            startTimerButton.setTitle("Stop", for: .normal)
            startTimerButton.setTitleColor(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), for: .normal)
            pauseTimerButton.setTitle("Pause", for: .normal)
        }else {
            isCounting = false
            timer.invalidate()
            startTimerButton.setTitle("Start", for: .normal)
            startTimerButton.setTitleColor(#colorLiteral(red: 0.08585167676, green: 0.9849846959, blue: 0.01088900492, alpha: 1), for: .normal)
            timerPicker.countDownDuration = 60
        }
        
    }
    @IBAction func pauseCountDown(_ sender: UIButton) {
        timer.invalidate()
        isCounting = false
        startTimerButton.setTitle("Start", for: .normal)
        startTimerButton.setTitleColor(#colorLiteral(red: 0.08585167676, green: 0.9849846959, blue: 0.01088900492, alpha: 1), for: .normal)
    }
    
    @objc func countDown(param: UIDatePicker){
        timerPicker.countDownDuration -= 1
        timerNumber -= 60
        print("count duration -> ", timerPicker.countDownDuration, "\n",
              "timer number -> ", timerNumber)
        if timerNumber == 0{
            playSound(state: isSilenceMode)
            let alertMess = UIAlertController(title: "Time out!", message: "", preferredStyle: .alert)
            alertMess.addAction(UIAlertAction(title: "Okay!", style: .default, handler: { _ in
                self.isCounting = false
                self.startTimerButton.setTitle("Start", for: .normal)
                self.startTimerButton.setTitleColor(#colorLiteral(red: 0.08585167676, green: 0.9849846959, blue: 0.01088900492, alpha: 1), for: .normal)
                self.player.stop()
            }))
            self.present(alertMess, animated: true, completion: nil)
            timer.invalidate()
            timerPicker.countDownDuration = 0
        }
    }
    
    func playSound(state: Bool){
        if state == false{
            guard let url = Bundle.main.url(forResource: "alarm", withExtension: "mp3") else { return }
            do{
                player = try AVAudioPlayer(contentsOf: url)
            }catch{
                print("no audio file")
            }
            player.play()
        } else {
            return
        }
    }
    
    @IBAction func turnOnOffSM(_ sender: UIButton) {
        if isSilenceMode == false{
            isSilenceMode = true
            silenceButton.setTitle("Turn Off SM", for: .normal)
            silenceButton.setTitleColor(.red, for: .normal)
            notificationLabel.isHidden = false
        } else {
            isSilenceMode = false
            silenceButton.setTitle("Silence Mode", for: .normal)
            silenceButton.setTitleColor(.systemBlue, for: .normal)
            notificationLabel.isHidden = true
        
        }
    }
    

}
