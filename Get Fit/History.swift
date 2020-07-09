//
//  History.swift
//  Get Fit
//
//  Created by Ewin Zuo on 7/8/20.
//  Copyright © 2020 Ewin Zuo. All rights reserved.
//

import Foundation

public class History: NSObject, NSCoding {
    public var user = "default_user"
    public var dailyHealth: [Health] = []
    
    public override init() {
        super.init()
    }
    init(hist: [Health], user: String) {
        dailyHealth = hist;
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(dailyHealth, forKey: "history")
        coder.encode(user, forKey: "user")
        
    }

    
    public required convenience init?(coder: NSCoder) {
        let history = coder.decodeObject(forKey: "history") as! [Health]
        let u = coder.decodeObject(forKey: "user") as! String
        self.init(hist: history, user: u)
    }
    
    
}
