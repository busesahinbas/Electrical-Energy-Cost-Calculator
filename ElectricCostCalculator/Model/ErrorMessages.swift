//
//  ErrorMessages.swift
//  ElectricCostCalculator
//
//  Created by Buse Şahinbaş on 5.06.2023.
//

import Foundation
import UIKit

func showAlert(title:Title, message:Message, view:UIViewController) {
    let alertController = UIAlertController(title: title.rawValue , message: message.rawValue, preferredStyle: .alert)
    let okAction = UIAlertAction(title: Title.ok.rawValue, style: .default, handler: nil)
    alertController.addAction(okAction)
    view.present(alertController, animated: true, completion: nil)
}

func showAlert(title:Title, message:String, view:UIViewController) {
    let alertController = UIAlertController(title: title.rawValue , message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: Title.ok.rawValue, style: .default, handler: nil)
    alertController.addAction(okAction)
    view.present(alertController, animated: true, completion: nil)
}

enum Title: String {
    case ok = "OK"
    case error = "Error"
    case validateError = "Validation Error"
}

enum Message: String {
    case invalidServiceNum = "Invalid service number. Please enter a 10-digit alphanumeric value."
    case invalidMeterReading = "Invalid meter reading. Please enter a positive numeric value."
    case empty =  "Service Number / Meter Reading fields can not be empty."
}
