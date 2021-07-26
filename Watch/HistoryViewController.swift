//
//  HistoryViewController.swift
//  Watch
//
//  Created by Mihael Matyatsko on 25.06.2021.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
 

    @IBOutlet weak var historyTableView: UITableView!
    var cellID = "historyCell"
    var amountInHistory: Int = 0
    var strMass = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "History records"
        
        historyTableView.dataSource = self
        historyTableView.delegate = self
        historyTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        historyTableView.isScrollEnabled = true
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return amountInHistory
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = historyTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let text = "Entry - \(indexPath.row + 1) : " + strMass[indexPath.row]
        cell.textLabel?.textAlignment = .left
        cell.textLabel?.text = text
            
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
  
    
}
