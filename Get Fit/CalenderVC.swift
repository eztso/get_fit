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
            return data.count
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data[sortedMonths[section]]!.count
        }
        
        func formatUIView(view: UIView) {
            view.layer.cornerRadius = 10.0
            view.layer.masksToBounds = true
            view.layer.borderColor = UIColor.white.cgColor
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! histCell
            if indexPath.section < sortedMonths.count {
                if indexPath.row < data[sortedMonths[indexPath.section]]!.count {
                    let d = data[sortedMonths[indexPath.section]]![indexPath.row]
                    cell.date.text? = d.date!
                    
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let date = dateFormatter.date(from:d.date!)!
                    
                    let dateFormat = DateFormatter()
                    dateFormat.dateFormat = "EEE, MMM d"
                    cell.date.text? = dateFormat.string(from: date)
                }
            }
            formatUIView(view: cell)
            cell.layer.borderColor = Constant.red.cgColor
            cell.layer.borderWidth = 4
            cell.date.backgroundColor = UIColor.clear
            formatUIView(view: cell.date)
            return cell
        }
        
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: SectionHeaderHeight))
            view.backgroundColor = Constant.green
            let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: SectionHeaderHeight))
            label.font = UIFont.boldSystemFont(ofSize: 15)
            label.textColor = UIColor.black
            if section < sortedMonths.count {
                label.text = sortedMonths[section]
            }
            formatUIView(view: label)
            label.backgroundColor = UIColor.clear
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
            data = [String: [Health]]()
            for item in Constant.healthdata.history.dailyHealth {
                let df = DateFormatter()
                df.dateFormat = "yyyy-MM-dd"
                if item.isValid {
                    let d = df.date(from: item.date!)
                    let df2 = DateFormatter()
                    df2.dateFormat = "yyyy-MM"
                    let str: String = df2.string(from: d!)
                    if data[str] == nil {
                        data[str] = []
                    }
                    data[str]!.append(item)
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
            tableView.reloadData()
            overrideUserInterfaceStyle = UserDefaults.standard.bool(forKey: "darkModeOn") ? .dark : .light
        }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let destination = segue.destination as? DayViewController,
                let row = tableView.indexPathForSelectedRow?.row, let section = tableView.indexPathForSelectedRow?.section{
                let df = DateFormatter()
                df.dateFormat = "yyyy-MM-dd"
                let d = df.date(from: data[sortedMonths[section]]![row].date!)
                destination.date = d
                destination.health = data[sortedMonths[section]]![row]
            }
        }
    }
    
    
    
    
    
