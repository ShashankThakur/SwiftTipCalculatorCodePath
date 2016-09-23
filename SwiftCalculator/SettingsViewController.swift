//
//  SettingsViewController.swift
//  SwiftCalculator
//
//  Created by Thakur, Shashank on 9/17/16.
//  Copyright © 2016 Thakur, Shashank. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    enum tips:Double {
        case fifteen = 0.15,twentyPercent = 0.20, thrityPercent = 0.30, zero = 0.00
        
    }
    
    func fetchSavedTip() ->Double
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        let tip = defaults.doubleForKey("tipPercent")
        if(tip == tips.fifteen.rawValue)
        {
            tipSwitcher.selectedSegmentIndex = 0
        }
        else if(tip == tips.twentyPercent.rawValue)
        {
            tipSwitcher.selectedSegmentIndex = 1
        }
        else if(tip == tips.thrityPercent.rawValue)
        {
            tipSwitcher.selectedSegmentIndex = 2
        }
        return tip != tips.zero.rawValue ? tip:tips.fifteen.rawValue
    }

    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchSavedTip()
        
    }
    @IBAction func tipChanged(sender: AnyObject) {
        var tip = 0.0
        switch tipSwitcher.selectedSegmentIndex
        {
        case 0:
            tip = tips.fifteen.rawValue
        case 1:
            tip = tips.twentyPercent.rawValue
        case 2:
            tip = tips.thrityPercent.rawValue
        default:
            break;
        }
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(tip, forKey: "tipPercent")
        defaults.synchronize()
        
        
    }
    @IBOutlet var tipSwitcher: UISegmentedControl!
    
    


}
