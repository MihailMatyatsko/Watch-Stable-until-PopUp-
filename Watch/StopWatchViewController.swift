//
//  StopWatchViewController.swift
//  Watch
//
//  Created by Mihael Matyatsko on 25.06.2021.
//

import UIKit

class StopWatchViewController: UIViewController {

    var timer: Timer = Timer()
    var counter: Int = 0
    var pressCounter: Int = 0
    var strArray = [String]()
   
    
    
    @IBOutlet weak var buttonViewContainer: UIView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var stopWatchLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.setTitle("Start", for: .normal)
        
        
        stopWatchLabel.text = "00 : 00 : 00"
        
        startButton.layer.cornerRadius = 0.5 * startButton.bounds.size.width
        startButton.clipsToBounds = true
        stopButton.layer.cornerRadius = 0.5 * stopButton.bounds.size.width
        stopButton.clipsToBounds = true
        resetButton.layer.cornerRadius = 0.5 * resetButton.bounds.size.width
        resetButton.clipsToBounds = true
        historyButton.layer.cornerRadius = 0.5 * historyButton.bounds.size.width
        historyButton.clipsToBounds = true
        
        startButton.isHidden = false
        stopButton.isHidden = true
        
        buttonViewContainer.layer.borderWidth = 1
        buttonViewContainer.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
    }
   
    @IBAction func didPressStart(_ sender: Any) {
        timer.invalidate()
        
        startButton.setTitle("Resume", for: .normal)
        startButton.setTitleColor(.orange, for: .normal)
        startButton.isHidden = true
        stopButton.isHidden = false
        
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(timerCount), userInfo: nil, repeats: true)
    }
    
    @IBAction func didPressStop(_ sender: Any) {
        startButton.isHidden = false
        stopButton.isHidden = true
        pressCounter += 1
        strArray.append(stopWatchLabel.text!)
        timer.invalidate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dest = segue.destination as? HistoryViewController else {
            return
        }
        dest.amountInHistory = strArray.count
        dest.strMass = strArray
    }
    
    @IBAction func didPressReset(_ sender: UIButton) {
        let alertMess = UIAlertController(title: "Reset Timer", message: "Are you sure?", preferredStyle: .alert)
        alertMess.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            // okay, close alert
        }))
        alertMess.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { _ in
            self.counter = 0
            self.timer.invalidate()
            self.stopWatchLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.startButton.setTitle("Start", for: .normal)
            self.startButton.setTitleColor(.green, for: .normal)
        }))
        self.present(alertMess, animated: true, completion: nil)
    }
    
    @objc func timerCount(){
        counter = counter + 1
        let currTime = secondsToTime(seconds: counter)
        let timeString = makeTimeString(hours: currTime.0, minutes: currTime.1, seconds: currTime.2)
        stopWatchLabel.text = timeString
    }
    
    func secondsToTime(seconds: Int) -> (Int, Int, Int){
        return ( (seconds / 3600), (( seconds % 3600 ) / 60), ((seconds % 3600) % 60 ))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String{
        var timeLine = ""
        timeLine += String(format: "%02d", hours)
        timeLine += " : "
        timeLine += String(format: "%02d", minutes)
        timeLine += " : "
        timeLine += String(format: "%02d", seconds)
        
        return timeLine
    }

}
