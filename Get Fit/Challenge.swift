//
//  Challenge.swift
//  Get Fit
//
//  Created by Ewin Zuo on 7/9/20.
//  Copyright © 2020 Ewin Zuo. All rights reserved.
//

import Foundation
class Challenge {
    let dispatch = DispatchGroup()
    let descriptions = ["Walk 6 miles today", "Take 8000 steps today", "Achieve a  BMI of 25 or less"]
    var idx: Int = 0
    var miles: Double = 0
    var steps: Int = 0
    var height: Double = 0
    init() {
        
        idx = Int.random(in: 0 ..< 3)
        
    }
    init(idx: Int) {
        self.idx = idx
    }
    func checkCompletion() -> Bool {
        dispatch.enter()
        DispatchQueue.global(qos: .default).async { () in
           Constant.healthdata.getTodaysMiles(completion: {(ans) -> Void in
                                 self.miles = ans
            self.dispatch.leave();
                                   })
            
        }
        dispatch.enter()
        DispatchQueue.global(qos: .default).async { () in
           Constant.healthdata.getTodaysSteps(completion: {(ans) -> Void in
                                 self.steps = Int(ans)
            self.dispatch.leave();
                                   })
            
        }
        dispatch.wait()
        var res = false
        switch(idx) {
        case 0:
            res = miles >= 6
            break;
            
        case 1:
            res = steps >= 8000
            break;
            
        case 2:
            res =  ((703.0 * Constant.healthdata.getHealthForDay().weight!) / pow(Constant.healthdata.getHeight() / 2.54, 2)) < 25.0
        default:
            res = false
        }
        return res
    }
    
}
