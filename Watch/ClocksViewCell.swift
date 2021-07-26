//
//  clocksViewCell.swift
//  Watch
//
//  Created by Mihael Matyatsko on 05.07.2021.
//

import UIKit

class ClocksViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var currentTime: UILabel!
    
    var timeZoneToShow : TimeZone?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.currentTime.text = self.showTime((self.timeZoneToShow ?? TimeZone(identifier: "Europe/Kiev")!))
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func showTime(_ timeZone: TimeZone) -> String{
        let date = Date()
        let outputFormat = DateFormatter()
        let zone = timeZone
        outputFormat.timeZone = zone
        outputFormat.locale = Locale(identifier:"en_US")
        outputFormat.dateFormat = "HH:mm:ss"
        let localDate = outputFormat.string(from: date)
        return localDate
    }
    
}
