//
//  ClockViewController.swift
//  Watch
//
//  Created by Mihael Matyatsko on 25.06.2021.
//

import UIKit

class ClockViewController: UIViewController {
    //MARK: - Variables
    let cellTimeId = "clock"
    let timeZoneToChoose = TimeZone.knownTimeZoneIdentifiers
    var timeIdentifierArray: [String] = ["Europe/Kiev", "America/Santiago"]
    let arrayTimeZone: [String] = TimeZone.knownTimeZoneIdentifiers
    
    //MARK: - Outlets
    @IBOutlet weak var timeClocksView: UITableView!
    @IBOutlet weak var popUpClockPicker: UIView!
    @IBOutlet weak var pickedTimeZone: UITextField!
    @IBOutlet weak var timeZonePicker: UIPickerView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegateAndDataSource()
        setupUI()
    }
    
    //MARK: - Actions
    @IBAction func openPopUP(_ sender: Any) {
        showPopUp()
    }
    
    @IBAction func closePopUp(_ sender: Any) {
        hidePopUP()
    }
    
    @IBAction func addTime(_ sender: Any) {
        guard let temp = pickedTimeZone.text else { return }
        timeIdentifierArray.append(temp)
        timeClocksView.reloadData()
        hidePopUP()
    }
    
    @IBAction func editButtonAction(_ sender: UIBarButtonItem) {
        if timeClocksView.isEditing == false{
            timeClocksView.allowsSelectionDuringEditing = true
            timeClocksView.setEditing(true, animated: true)
        } else {
            timeClocksView.setEditing(false, animated: true)
        }
    }
}
