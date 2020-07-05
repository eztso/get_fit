//
//  updater.swift
//  Get Fit
//
//  Created by Ewin Zuo on 7/5/20.
//  Copyright © 2020 Ewin Zuo. All rights reserved.
//

import Foundation

protocol Updater {
    func updateFoodProtein(protein: Double)
    func updateFoodFat(fat: Double)
    func updateFoodCalories(calories: Double)
    func updateFoodSugar(sugar: Double)
}
