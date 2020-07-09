//
//  Health.swift
//  Get Fit
//
//  Created by Ewin Zuo on 7/8/20.
//  Copyright © 2020 Ewin Zuo. All rights reserved.
//

import Foundation

public class Health: NSObject, NSCoding {
    var date : String? = ""
    var caloriesBurned: Double? = 0
    var foodCalories: Double? = 0
    var foodProtein: Double? = 0
    var foodFat: Double? = 0
    var foodSugar:Double? = 0
    var weight: Double? = 0
    var isValid : Bool = false;

    public func encode(with coder: NSCoder) {
        coder.encode(caloriesBurned!, forKey: "caloriesBurned")
        coder.encode(foodCalories!, forKey: "foodCalories")
        coder.encode(foodProtein!, forKey: "foodProtein")
        coder.encode(foodFat!, forKey: "foodFat")
        coder.encode(foodSugar!, forKey: "foodSugar")
        coder.encode(date!, forKey: "date")
        coder.encode(weight!, forKey: "weight")

        
        
    }
    init(cb: Double, fc: Double, fp: Double, ff: Double, fs: Double, iv: Bool, d: String, w: Double){
        self.caloriesBurned = cb
        self.foodCalories = fc
        self.foodFat = ff
        self.foodSugar = fs
        self.foodProtein = fp
        self.isValid = iv
        self.date = d
        self.weight = w
        
    }
    public required convenience init?(coder: NSCoder) {
        let cb = coder.decodeDouble(forKey: "caloriesBurned")
        let fc = coder.decodeDouble(forKey: "foodCalories")
        let fp = coder.decodeDouble(forKey: "foodProtein")
        let ff = coder.decodeDouble(forKey: "foodFat")
        let fs = coder.decodeDouble(forKey: "foodSugar")
        let iv = coder.decodeBool(forKey: "isValid")
        let d = coder.decodeObject(forKey: "date") as! String
        let w = coder.decodeDouble(forKey: "weight")

        self.init(cb: cb, fc: fc, fp: fp, ff:ff, fs: fs, iv: iv, d: d, w: w)
        
    }
    public override init() {
        super.init()
    }
    
    
    
    
}
