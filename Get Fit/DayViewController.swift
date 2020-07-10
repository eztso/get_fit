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
    var health : Health?
    var dispatch = DispatchGroup()
    
    var linechartView = Charts.LineChartView()
    var radarChartView = Charts.RadarChartView()
    var button = UIButton()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getLineChartData()
        var entries = [ChartDataEntry]()
        for i in 0..<stepsData.count {
            let y_ = stepsData[i]
            let value = ChartDataEntry(x: Double(i), y : y_)
            entries.append(value)
        }
        let line1 = LineChartDataSet(entries: entries, label: "Steps")
        line1.colors = [Constant.red]
        line1.circleHoleColor = Constant.green
        line1.setCircleColors(Constant.blue)
        
        line1.lineWidth = 2
        
        var entries_b = [ChartDataEntry]()
        entries_b.append(ChartDataEntry(x: 0.0, y : Double(Constant.recSteps)))
        entries_b.append(ChartDataEntry(x: 23.0, y : Double(Constant.recSteps)))
        
        let line2 = LineChartDataSet(entries: entries_b, label: "Recommended")
        line2.colors = [Constant.green]
        
        
        line2.lineWidth = 2
        line2.drawCirclesEnabled = false
        
        let xAxis = linechartView.xAxis
        xAxis.xOffset = 10
        xAxis.labelFont = .systemFont(ofSize: 9, weight: .bold)
        xAxis.valueFormatter = XAxisFormatterLinePlot()
        
        
        let data = LineChartData()
        data.addDataSet(line1)
        data.addDataSet(line2)
        linechartView.data = data
        linechartView.chartDescription?.text = "Step Count(24 hr)"
        
        var entries2 = [ChartDataEntry]()
        let temp : [Double] = [health!.foodFat!, health!.foodProtein!, health!.foodSugar!]
        for i in 0..<temp.count  {
            let y_ = temp[i]
            print(i)
            let value = ChartDataEntry(x: Double(i), y : y_)
            entries2.append(value)
        }
        
        
        
        let radar1data = RadarChartDataSet(entries: entries2, label: "You")
        radar1data.colors = [Constant.red]
        radar1data.fillColor = Constant.red_trans
        radar1data.drawFilledEnabled = true
        radar1data.lineWidth = 2
        radar1data.valueFormatter = DataSetValueFormatter()
        var entries3 = [ChartDataEntry]()
        
        let temp2 : [Double] = [83.0, 63.0, 40.0]
        for i in 0..<temp.count  {
            let y_ = temp2[i]
            print(i)
            let value = ChartDataEntry(x: Double(i), y : y_)
            entries3.append(value)
        }
        let radar2data = RadarChartDataSet(entries: entries3, label: "Recommended")
        radar2data.colors = [Constant.green]
        radar2data.fillColor = Constant.green_trans
        radar2data.drawFilledEnabled = true
        radar2data.lineWidth = 2
        radar2data.valueFormatter = DataSetValueFormatter()
        
        
        let r_xAxis = radarChartView.xAxis
        r_xAxis.labelFont = .systemFont(ofSize: 9, weight: .bold)
        r_xAxis.labelFont = .systemFont(ofSize: 9, weight: .bold)
        
        r_xAxis.xOffset = 10
        r_xAxis.yOffset = 10
        r_xAxis.valueFormatter = XAxisFormatter()
        
        
        let r_data = RadarChartData()
        r_data.addDataSet(radar1data)
        r_data.addDataSet(radar2data)
        
        radarChartView.data = r_data
        radarChartView.chartDescription?.text = "Diet"
        radarChartView.webLineWidth = 1.5
        radarChartView.innerWebLineWidth = 1.5
        radarChartView.webColor = .lightGray
        radarChartView.innerWebColor = .lightGray
        
        // 3
        
        
        // 4
        let yAxis = radarChartView.yAxis
        yAxis.labelFont = .systemFont(ofSize: 9, weight: .light)
        yAxis.labelCount = 6
        yAxis.axisMinimum = 0
        yAxis.valueFormatter = YAxisFormatter()
        
        // 5
        
        
        testScrollview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        overrideUserInterfaceStyle = UserDefaults.standard.bool(forKey: "darkModeOn") ? .dark : .light
    }
    
    
    func testScrollview() {
        let myButton = UIButton(type: .system)

        myButton.backgroundColor = UIColor.black
        myButton.layer.cornerRadius = 10.0
        myButton.layer.masksToBounds = true
        myButton.setTitleColor(Constant.red, for: .normal)
        
        contentView.addSubview(linechartView)
        contentView.addSubview(radarChartView)
        scrollView.addSubview(myButton)

        linechartView.translatesAutoresizingMaskIntoConstraints = false
        radarChartView.translatesAutoresizingMaskIntoConstraints = false
        myButton.translatesAutoresizingMaskIntoConstraints = false

        
        linechartView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        linechartView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        linechartView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        linechartView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        linechartView.bottomAnchor.constraint(equalTo: radarChartView.topAnchor).isActive = true
        
        
        radarChartView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        radarChartView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
         
        radarChartView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        radarChartView.bottomAnchor.constraint(equalTo: myButton.topAnchor).isActive = true
        
        // Create UIButton
        myButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        myButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        myButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        myButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        
        // Set text on button
        myButton.setTitle("Metrics", for: .normal)
        
        // Set button action
        myButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        
        
        //        linechartView.bottomAnchor.constraint(equalTo: imageView2.topAnchor).isActive = true
        
        self.contentView.setNeedsLayout()
    }
    
    let metricsSegueIdentifier: String = "MetricsSegueIdentifier"
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // If we are changing text, we want to pass the default
        // value of the input text field
        if segue.identifier == metricsSegueIdentifier, let targetViewController = segue.destination as? PastDayReviewViewController {
            targetViewController.health = self.health
            var steps: Double = 0.0
            for step in self.stepsData {
                steps += step
            }
            targetViewController.steps = steps
        }
    }
    
    @objc func buttonAction(_ sender:UIButton!)
    {
        self.performSegue(withIdentifier: metricsSegueIdentifier, sender: nil)
    }
    
    func getLineChartData() {
        self.stepsData = []
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
        self.stepsData = self.stepsData
            .reduce(into: []) { $0.append(($0.last ?? 0) + $1) }
        
        
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
class XAxisFormatterLinePlot: IAxisValueFormatter {
    
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        String(Int(value))
    }
}
class DataSetValueFormatter: IValueFormatter {
    
    func stringForValue(_ value: Double,
                        entry: ChartDataEntry,
                        dataSetIndex: Int,
                        viewPortHandler: ViewPortHandler?) -> String {
        ""
    }
}

// 2
class XAxisFormatter: IAxisValueFormatter {
    
    let titles = ["Fat" , "Protein","Sugar"]
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        titles[Int(value) % titles.count]
    }
}

// 3
class YAxisFormatter: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        "\(Int(value)) (g)"
    }
}
