//
//  CalenderVC.swift
//  Get Fit
//
//  Created by Ewin Zuo on 7/9/20.
//  Copyright © 2020 Ewin Zuo. All rights reserved.
//

import UIKit

class CalenderVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    let SectionHeaderHeight: CGFloat = 25
    func numberOfSections(in tableView: UITableView) -> Int {
        print(data.count)
        return data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            print("in number of rows in section")
            print(data[sortedMonths[section]]!.count)
            return data[sortedMonths[section]]!.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! histCell
        if indexPath.section < sortedMonths.count {
            if indexPath.row < data[sortedMonths[indexPath.section]]!.count {
                print("in cell for row at")
                let d = data[sortedMonths[indexPath.section]]![indexPath.row]
                cell.date.text? = d.date!
                }
   
            }
            
        return cell

    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: SectionHeaderHeight))
      view.backgroundColor = UIColor(red: 253.0/255.0, green: 240.0/255.0, blue: 196.0/255.0, alpha: 1)
      let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: SectionHeaderHeight))
      label.font = UIFont.boldSystemFont(ofSize: 15)
      label.textColor = UIColor.black
      if section < sortedMonths.count {
        label.text = sortedMonths[section]
      }
      view.addSubview(label)
      return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      // If we wanted to always show a section header regardless of whether or not there were rows in it,
      // then uncomment this line below:
      //return SectionHeaderHeight
      // First check if there is a valid section of table.
      // Then we check that for the section there is more than 1 row.
        if section < sortedMonths.count, let d = data[sortedMonths[section]], d.count > 0 {
        return SectionHeaderHeight
      }
      return 0
    }
    
    
    var data = [String: [Health]]()
    var sortedMonths = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("appeared")
        data = [String: [Health]]()
        for item in Constant.healthdata.history.dailyHealth {
            print(item.date!)
            print(item.isValid)
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            if item.isValid {
                print(item.date!)
                let d = df.date(from: item.date!)
                let df2 = DateFormatter()
                df2.dateFormat = "yyyy-MM"
                let str: String = df2.string(from: d!)
                if data[str] == nil {
                    data[str] = []
                }
                data[str]!.append(item)
                print(data.count)
            }
            
            
        }
        for (k, _)in data {
            data[k]!.sort( by: { (first: Health, second: Health) -> Bool in
                first.date! < second.date!
            })
            
        }
        
        sortedMonths = Array(data.keys).sorted(by: { (k1, k2) -> Bool in
            k1 < k2
        })
        for i in sortedMonths {
            print(i)
        }
        tableView.reloadData()
        
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
