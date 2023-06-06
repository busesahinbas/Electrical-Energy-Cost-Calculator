//
//  Calculation.swift
//  ElectricCostCalculator
//
//  Created by Buse Şahinbaş on 5.06.2023.
//

import Foundation

func calculateCost(previousReading: Int?, currentReading: Int) -> Int {
    
    let consumption = currentReading - (previousReading ?? 0)
    
    var cost: Int = 0
    
    if consumption <= upperLimit1 {
        cost = consumption * rate1
    } else if consumption <= upperLimit2 {
        let slab1Cost = upperLimit1 * rate1
        let remainingUnits = consumption - upperLimit1
        cost = slab1Cost + (remainingUnits * rate2)
    } else {
        let slab1Cost = upperLimit1 * rate1
        let slab2Cost = (upperLimit2 - upperLimit1) * rate2
        let remainingUnits = consumption - upperLimit2
        cost = slab1Cost + slab2Cost + (remainingUnits * rate3)
    }
    print(cost)
    return cost
}
