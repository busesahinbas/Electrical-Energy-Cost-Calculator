//
//  Util.swift
//  ElectricCostCalculator
//
//  Created by Buse Şahinbaş on 5.06.2023.
//

import Foundation

func isServiceNumberValid(_ serviceNumber: String) -> Bool {
    let serviceNumberRegex = "^[A-Za-z0-9]{10}$"
    let serviceNumberPredicate = NSPredicate(format: "SELF MATCHES %@", serviceNumberRegex)
    return serviceNumberPredicate.evaluate(with: serviceNumber)
}

func isMeterReadingValid(_ meterReading: String) -> Bool {
    guard let numericValue = Double(meterReading) else {
        return false
    }
    
    return numericValue > 0
}
