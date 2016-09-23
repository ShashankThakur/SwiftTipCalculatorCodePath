//
//  BillHistoryViewController.swift
//  SwiftCalculator
//
//  Created by Thakur, Shashank on 9/19/16.
//  Copyright © 2016 Thakur, Shashank. All rights reserved.
//

import UIKit


class BillHistoryViewController: UITableViewController {

    var billHistory = [[String]]()
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let defaults = NSUserDefaults.standardUserDefaults()
        billHistory = defaults.objectForKey("BillsArray") as? [[String]] ?? [[String]]()
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return billHistory.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:BillHistoryCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as! BillHistoryCell
        
        var billEntry = billHistory[indexPath.row]
        cell.baseBillLabel.text = billEntry[0]
        cell.tipLabel.text = billEntry[1]
        cell.totalBillLabel.text = billEntry[2]
        return cell
    }
    
}
