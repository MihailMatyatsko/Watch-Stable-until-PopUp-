//
//  extenClockVC.swift
//  Watch
//
//  Created by Mihael Matyatsko on 07.07.2021.
//

import Foundation
import UIKit

extension ClockViewController: UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource{
    
    //MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeIdentifierArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = timeClocksView.dequeueReusableCell(withIdentifier: cellTimeId, for: indexPath) as! ClocksViewCell
        cell.cityName.text = timeIdentifierArray[indexPath.row]
        cell.infoLabel.text = "Now at that place"
        cell.timeZoneToShow = TimeZone(identifier: timeIdentifierArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.kCellHeight
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return timeClocksView.bounds.height - (Constants.kCellHeight * CGFloat(timeIdentifierArray.count))
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObj = timeIdentifierArray[sourceIndexPath.item]
        timeIdentifierArray.remove(at: sourceIndexPath.item)
        timeIdentifierArray.insert(movedObj, at: destinationIndexPath.item)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            timeIdentifierArray.remove(at: indexPath.item)
            timeClocksView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    
    //MARK: - PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        arrayTimeZone.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayTimeZone[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedTimeZone.text = arrayTimeZone[row]
        pickedTimeZone.resignFirstResponder()
    }
    
    func delegateAndDataSource(){
        timeClocksView.dataSource = self
        timeClocksView.delegate = self
        timeZonePicker.dataSource = self
        timeZonePicker.delegate = self
    }
    
    func setupUI(){
        popUpClockPicker.isHidden = true
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        confirmButton.layer.cornerRadius = 0.5 * confirmButton.bounds.size.width
        cancelButton.layer.cornerRadius = 0.5 * cancelButton.bounds.size.width
        popUpClockPicker.layer.cornerRadius = 0.5 * popUpClockPicker.bounds.size.width
        popUpClockPicker.layer.borderWidth = 0.25
        popUpClockPicker.layer.borderColor = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1).cgColor
        
        pickedTimeZone.inputView = timeZonePicker
        timeClocksView.register(UINib(nibName: "ClocksViewCell", bundle: nil), forCellReuseIdentifier: cellTimeId)
    }
    
    func showPopUp(){
        popUpClockPicker.isHidden = false
        popUpClockPicker.layer.zPosition = 1
    }
    
    func hidePopUP(){
        popUpClockPicker.isHidden = true
        popUpClockPicker.layer.zPosition = 0
    }
    
    
    enum Constants {
        static let kCellHeight : CGFloat = 100.0
    }
}
