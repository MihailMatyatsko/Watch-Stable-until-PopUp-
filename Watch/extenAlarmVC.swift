//
//  extenAlarmVC.swift
//  Watch
//
//  Created by Mihael Matyatsko on 07.07.2021.
//

import Foundation
import UIKit

extension AlarmViewController : UITableViewDelegate, UITableViewDataSource{
    //MARK: - TableView(Alarms)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableAlarmView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? AlarmView {
            cell.timeLabel.text = getTimeFromPicker(pickedTime: timesArray[indexPath.row])
            cell.fireTime = timesArray[indexPath.row]
            return cell
        }
        return UITableViewCell(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: Constants.cellHeight))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return tableAlarmView.bounds.height - (Constants.cellFooterSpacing * CGFloat(timesArray.count))
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedAlarm = timesArray[sourceIndexPath.item]
        timesArray.remove(at: sourceIndexPath.item)
        timesArray.insert(movedAlarm, at: destinationIndexPath.item)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            timesArray.remove(at: indexPath.item)
            tableAlarmView.deleteRows(at: [indexPath], with: .right)
        }
    }
    
    func showPopUp(){
        popUpView.isHidden = false
        popUpView.layer.zPosition = 1
    }
    
    func hidePopUP(){
        popUpView.isHidden = true
        popUpView.layer.zPosition = 0
    }
    
    func delegateAndDataSource(){
        tableAlarmView.delegate = self
        tableAlarmView.dataSource = self
    }
    
    func setupUI(){
        dismissButton.layer.cornerRadius = 6
        dismissButton.clipsToBounds = true
        confirmButton.layer.cornerRadius = 6
        confirmButton.clipsToBounds = true
        popUpView.layer.cornerRadius = 5
        popUpView.layer.borderWidth = 0.3
        popUpView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor
    }
    
    enum Constants {
        static let cellHeight: CGFloat = 100.0
        static let cellFooterSpacing: CGFloat = 110.0
    }
}
