//
//  ViewController.swift
//  ElectricCostCalculator
//
//  Created by Buse Şahinbaş on 5.06.2023.
//

import UIKit
import CoreData
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var serviceNumber: UITextField!
    @IBOutlet weak var meterReading: UITextField!
    var finalArray = [[Int]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        if (validateInputs()){
            getAndCalculate()
        }
    }
    
    func validateInputs() -> Bool{
        if serviceNumber.text == "" || meterReading.text == "" {
            showAlert(title: .error, message: .empty, view: self)
            return false
        }
        
        guard let serviceNumberText = serviceNumber.text, let meterReadingText = meterReading.text else {
            return false
        }
        
        if !isServiceNumberValid(serviceNumberText) {
            showAlert(title: .validateError, message: .invalidServiceNum, view: self)
            return false
        }
        
        if !isMeterReadingValid(meterReadingText) {
            showAlert(title: .validateError, message: .invalidMeterReading, view: self)
            return false
        }
        
        return true
    }
    
    func getAndCalculate() {
        let db = Firestore.firestore()
        
        guard let serviceNum = serviceNumber.text, let newRead = Int(meterReading.text ?? "0")  else {
            return
        }
        
        db.collection("cost").document(serviceNum).getDocument { (document, error) in
            if let error = error {
                showAlert(title: .error, message: error.localizedDescription, view: self)
                return
            }
            
            guard let document = document, document.exists else {
                // Document doesn't exist, create a new one
                
                db.collection("cost").document(serviceNum).setData([
                    "read1": newRead,
                    "read2": 0,
                    "read3": 0,
                    "cost1": calculateCost(previousReading: nil, currentReading: newRead),
                    "cost2": 0,
                    "cost3": 0
                    
                ]) { error in
                    if let error = error {
                        showAlert(title: .error, message: error.localizedDescription, view: self)
                        return
                    }
                }
                return
            }
            
            // Document already exists, update its fields
            guard let read1 = document.get("read1") as? Int else { return }
            var read2 = document.get("read2") as? Int ?? 0
            var read3 = document.get("read3") as? Int ?? 0
            var cost1 = document.get("cost1") as? Int ?? 0
            var cost2 = document.get("cost2") as? Int ?? 0
            var cost3 = document.get("cost3") as? Int ?? 0
            
            if read1 != 0 {
                read2 = newRead
                cost2 = calculateCost(previousReading: read1, currentReading: newRead)
            }
            
            if read1 != 0 && read2 != 0 {
                read3 = newRead
                cost3 = calculateCost(previousReading: read2, currentReading: newRead)
            }
            
            db.collection("cost").document(serviceNum).updateData([
                "read1": read1,
                "read2": read2,
                "read3": read3,
                "cost1": cost1,
                "cost2": cost2,
                "cost3": cost3
            ]) { error in
                if let error = error {
                    showAlert(title: .error, message: error.localizedDescription, view: self)
                    return
                }
            }
            self.finalArray = [[read1, cost1], [read2, cost2], [read3, cost3]]
            print(self.finalArray)
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CostViewController") as? CostViewController
            vc?.serviceNumber = self.serviceNumber.text
            vc?.newReading = Int(self.meterReading.text ?? "")
            vc?.dataArray = self.finalArray
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
}


