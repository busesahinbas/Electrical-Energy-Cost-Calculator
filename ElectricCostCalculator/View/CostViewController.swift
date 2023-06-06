//
//  CostViewController.swift
//  ElectricCostCalculator
//
//  Created by Buse Şahinbaş on 5.06.2023.
//

import UIKit
import Firebase

class CostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var serviceNumber : String?
    var newReading : Int?
    var dataArray : [[Int]]?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var serviceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceLabel.text = serviceNumber
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
     
        content.text = String(dataArray?[indexPath.row][0] ?? 0)
        content.secondaryText = String(dataArray?[indexPath.row][1] ?? 0)
        cell.contentConfiguration = content
        
        return cell
    }
    
   
}

