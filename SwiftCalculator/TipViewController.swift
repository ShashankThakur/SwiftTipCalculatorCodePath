//
//  ViewController.swift
//  SwiftCalculator
//
//  Created by Thakur, Shashank on 9/16/16.
//  Copyright © 2016 Thakur, Shashank. All rights reserved.
//

import UIKit

class TipViewController: UIViewController,UITextFieldDelegate {

    enum tips:Double {
        case fifteen = 0.15,twentyPercent = 0.20, thrityPercent = 0.30, zero = 0.00
        
    }
    var currentTip = 0.0
    var tipNSegmentIndexMap:[Double:Int] = [tips.fifteen.rawValue:0,tips.twentyPercent.rawValue:1,tips.thrityPercent.rawValue:2]
    @IBOutlet var billAmountTextField: UITextField!

    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        billAmountTextField.delegate = self
        initialSetUp()
        
    }
    override func viewWillAppear(animated: Bool) {
        billAmountTextField .becomeFirstResponder()
        currentTip = fetchSavedTip()
        tipSwitcher.selectedSegmentIndex = tipNSegmentIndexMap[currentTip]!
        if !(billAmountTextField.text?.isEmpty)!
        {
            let baseBill = Double(billAmountTextField.text!)!
            totalBill.text = calculateFinalAmount(baseBill, tip: currentTip)
        }
        

        
    }
    func initialSetUp()
    {
        totalBill.text = tips.zero.rawValue.asLocaleCurrency
        tipLabel.text = tips.zero.rawValue.asLocaleCurrency
    }
    
    
    @IBOutlet var tipLabel: UILabel!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBOutlet var totalBill: UILabel!
    
    @IBOutlet var tipSwitcher: UISegmentedControl!
    
    @IBAction func changeBaseBill(sender: AnyObject) {
        if(billAmountTextField.text?.characters.count > 0)
        {
            let baseBill = Double(billAmountTextField.text!)!
            totalBill.text = calculateFinalAmount(baseBill, tip: currentTip)
        }
        else
        {
            totalBill.text = tips.zero.rawValue.asLocaleCurrency
        }
    }
    
    @IBAction func tipPercent(sender: AnyObject) {
        if(!billAmountTextField.text!.isEmpty)
        {
            switch tipSwitcher.selectedSegmentIndex
            {
            case 0:
                currentTip = tips.fifteen.rawValue
            case 1:
                currentTip = tips.twentyPercent.rawValue
            case 2:
                currentTip = tips.thrityPercent.rawValue
            default:
                break;
            }
            let baseBill = Double(billAmountTextField.text!)!
            
            totalBill.text = calculateFinalAmount(baseBill, tip: currentTip)
        }
    }
    
    
    @IBAction func saveBill(sender: AnyObject) {
        if billAmountTextField.text?.characters.count != 0
        {
            let baseBill = Double(billAmountTextField.text!)!
            let billEntry = [baseBill.asLocaleCurrency,tipLabel.text!,totalBill.text!]
            

            var fetchedBillsArray:[[String]] = fetchSavedBills()
            fetchedBillsArray.insert(billEntry, atIndex: 0)
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(fetchedBillsArray, forKey: "BillsArray")
            
        }
    }
    
    func fetchSavedBills() ->[[String]]
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        let array = defaults.objectForKey("BillsArray") as? [[String]] ?? [[String]]()
        return array
    }
    
    func calculateFinalAmount(bill:Double,tip:Double) -> String
    {
        let finalAmount = bill + (bill * tip)
        tipLabel.text = (bill * tip).asLocaleCurrency
        saveTipToPersistentPlace(tip)
        return finalAmount.asLocaleCurrency
    }
    func saveTipToPersistentPlace(tip:Double)
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(tip, forKey: "tipPercent")
        defaults.synchronize()
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

    
}

// MARK: Extension for currency

public extension Double {
    var asLocaleCurrency:String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        formatter.usesGroupingSeparator = true
        return formatter.stringFromNumber(self)!
    }
}


