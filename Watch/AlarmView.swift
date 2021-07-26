//
//  AlarmView.swift
//  Watch
//
//  Created by Mihael Matyatsko on 05.07.2021.
//

import UIKit
import AVFoundation

class AlarmView: UITableViewCell {
    
    let nibName = "AlarmView"
    var timer = Timer()
    var fireTime = Date()
    var player = AVAudioPlayer()
    var interval: TimeInterval = 0.0

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var activationSwitch: UISwitch!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        activationSwitch.isOn = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
   
    @IBAction func turnOnOff(_ sender: UISwitch) {
        if activationSwitch.isOn == true{
            let now = Date().timeIntervalSince1970
            interval = fireTime.timeIntervalSince1970 - now
            timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false, block: { _ in
                self.playSound()
                self.activationSwitch.isOn = false
                _ = Timer.scheduledTimer(withTimeInterval: 15.0, repeats: false) { timer in
                    timer.invalidate()
                }
            })
        } else {
            timer.invalidate()
        }
    }
    
   func playSound(){
        timer.invalidate()
        guard let url = Bundle.main.url(forResource: "alarm", withExtension: "mp3") else { return }
        do{
            player = try AVAudioPlayer(contentsOf: url)
        }catch{
            print("no audio file")
        }
        player.play()
       
    }
    
}
