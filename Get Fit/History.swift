//
//  History.swift
//  Get Fit
//
//  Created by Ewin Zuo on 7/8/20.
//  Copyright © 2020 Ewin Zuo. All rights reserved.
//

import Foundation

public class History: NSObject, NSCoding {
    public var dailyHealth: [Health] = []
    
    public override init() {
        super.init()
    }
    init(hist: [Health]) {
        dailyHealth = hist;
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(dailyHealth, forKey: "history")
        
    }

    
    public required convenience init?(coder: NSCoder) {
        let history = coder.decodeObject(forKey: "history") as! [Health]
        self.init(hist: history)
    }
    
    
}
