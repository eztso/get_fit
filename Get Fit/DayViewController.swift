//
//  DayViewController.swift
//  Get Fit
//
//  Created by Ewin Zuo on 7/9/20.
//  Copyright © 2020 Ewin Zuo. All rights reserved.
//

import UIKit
import Charts

class DayViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        testScrollview()
        
        // Do any additional setup after loading the view.
    }
    var stepsData : [Double] = []
    var date : Date?
    var dispatch = DispatchGroup()
    
    var linechartView = Charts.LineChartView()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getLineChartData()
        var entries = [ChartDataEntry]()
        for i in 0..<stepsData.count {
            let y_ = stepsData[i]
            let value = ChartDataEntry(x: Double(i), y : y_)
            entries.append(value)
        }
        let line1 = LineChartDataSet(entries: entries, label: "Number")
        line1.colors = [Constant.red]
        line1.circleHoleColor = Constant.green
        line1.setCircleColors(Constant.blue)
        
        
        let xAxis = linechartView.xAxis
        xAxis.xOffset = 10
        xAxis.labelFont = .systemFont(ofSize: 9, weight: .bold)
        
        let data = LineChartData()
        data.addDataSet(line1)
        linechartView.data = data
        linechartView.chartDescription?.text = "Step Count(24 hr)"
        
        
        testScrollview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        overrideUserInterfaceStyle = UserDefaults.standard.bool(forKey: "darkModeOn") ? .dark : .light
    }
    
    
    func testScrollview() {
      
        contentView.addSubview(linechartView)
        linechartView.translatesAutoresizingMaskIntoConstraints = false
        linechartView.translatesAutoresizingMaskIntoConstraints = false
        
        linechartView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        linechartView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        linechartView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        linechartView.heightAnchor.constraint(equalToConstant: 400).isActive = true
//        linechartView.bottomAnchor.constraint(equalTo: imageView2.topAnchor).isActive = true
    
        
        self.contentView.setNeedsLayout()
    }
    
    func getLineChartData() {
        var s1 = Calendar.current.startOfDay(for: date!)
        var s2 = s1 + 60 * 60
        let end = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: date!)!
        while(s1 <= end) {
            dispatch.enter()
            DispatchQueue.global(qos: .default).sync {
                Constant.healthdata.getSteps(s1: s1, s2: s2, completion: {(ans) in self.stepsData.append(ans)
                    self.dispatch.leave()
                })
            }
            dispatch.wait()
            s1 = s2
            s2 = s1 + 60 * 60
            
        }
        
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
