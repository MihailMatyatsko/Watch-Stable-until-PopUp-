//
//  AlarmViewController.swift
//  Watch
//
//  Created by Mihael Matyatsko on 25.06.2021.
//

import UIKit
import AVFoundation

class AlarmViewController: UIViewController {
    //MARK: - Variables
    var cellId = "alarm"
    var timesArray: [Date] = []
    //MARK: - Outlets
    @IBOutlet weak var tableAlarmView: UITableView!
    @IBOutlet weak var alarmTimePicker: UIDatePicker! // time
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var popUpView: UIView!              // window to add alarm
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    
    
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableAlarmView.register(UINib(nibName: "AlarmView", bundle: nil), forCellReuseIdentifier: cellId)
        delegateAndDataSource()
        hidePopUP()
        setupUI()
    }
    
    func getTimeFromPicker(pickedTime: Date) -> String{
        let date = pickedTime
        let outputFormat = DateFormatter()
        outputFormat.locale = Locale(identifier:"en_US")
        outputFormat.dateFormat = "HH:mm"
        return outputFormat.string(from: date)
    }
    
    @IBAction func addAlarmBarButton(_ sender: UIBarButtonItem) {
        showPopUp()
    }
    
    @IBAction func cancelAddingAlarm(_ sender: UIButton) {
        hidePopUP()
    }
    
    @IBAction func addAlarm(_ sender: UIButton) {
        timesArray.append(alarmTimePicker.date)
        tableAlarmView.reloadData()
        hidePopUP()
    }
    
    @IBAction func startOrEndEditing(_ sender: UIBarButtonItem) {
        if tableAlarmView.isEditing == false{
            tableAlarmView.setEditing(true, animated: true)
            tableAlarmView.isEditing = true
        } else {
            tableAlarmView.isEditing = false
            tableAlarmView.setEditing(false, animated: true)
        }
    }
}
