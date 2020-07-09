//
//  History.swift
//  Get Fit
//
//  Created by Ewin Zuo on 7/8/20.
//  Copyright © 2020 Ewin Zuo. All rights reserved.
//

import Foundation

public class History: NSObject, NSCoding {
    public var user = Constant.defaultUser
    public var dailyHealth: [Health] = []
    public var points : Int = 0
    
    
    public override init() {
        super.init()
    }
    
    init(hist: [Health], user: String, points: Int) {
        dailyHealth = hist;
        self.user = user
        self.points = points
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(dailyHealth, forKey: "history")
        coder.encode(user, forKey: "user")
        coder.encode(points, forKey: "points")
       
        
    }

    
    public required convenience init?(coder: NSCoder) {
        let history = coder.decodeObject(forKey: "history") as! [Health]
        let u = coder.decodeObject(forKey:"user") as! String
        let p = coder.decodeInt32(forKey: "points")
      
        self.init(hist: history, user: u, points: Int(p))
    }
    
    
}
