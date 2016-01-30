//
//  ViewController.swift
//  tips
//
//  Created by luong ngoc on 1/24/16.
//  Copyright © 2016 luong ngoc. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {
    @IBOutlet weak var billingTextField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var billingLabel: UILabel!
    @IBOutlet weak var tipTitleLabel: UILabel!
    @IBOutlet weak var totalTitleLabel: UILabel!
    @IBOutlet weak var countStepper: UIStepper!
    @IBOutlet weak var peopleCount: UILabel!
    @IBOutlet weak var paymentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let edditedTime = defaults.objectForKey("eddited_time") as? NSDate {
            let interval = Int(NSDate().timeIntervalSinceDate(edditedTime))
            
            if interval < 600 {
                billingTextField.text = String(defaults.objectForKey("billing_ammount")!)
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let defaultPercentageIndex = defaults.integerForKey("default_tip_percentage")
        tipControl.selectedSegmentIndex = defaultPercentageIndex
        setTipText(defaultPercentageIndex)
        tipLabel.textColor = UIColor.whiteColor()
        totalLabel.textColor = UIColor.whiteColor()
        billingLabel.textColor = UIColor.whiteColor()
        peopleCount.textColor = UIColor.whiteColor()
        countStepper.tintColor = UIColor.whiteColor()
        paymentLabel.textColor = UIColor.whiteColor()
        tipTitleLabel.textColor = UIColor.whiteColor()
        totalTitleLabel.textColor = UIColor.whiteColor()
        tipControl.tintColor = UIColor.whiteColor()
        billingTextField.backgroundColor = UIColor.clearColor()
        billingTextField.textColor = UIColor.whiteColor()
        
        let darkTheme = defaults.boolForKey("dark_theme")
        if darkTheme {
            topView.backgroundColor = UIColor(red: 13/225, green: 48/225, blue: 93/225, alpha: 1)
            view.backgroundColor = UIColor(red: 5/225, green: 33/225, blue: 70/225, alpha: 1)
        } else {
            topView.backgroundColor = UIColor(red: 114/225, green: 163/225, blue: 225/225, alpha: 1)
            view.backgroundColor = UIColor(red: 74/225, green: 136/225, blue: 215/225, alpha: 1)
        }
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        let percentage_index = tipControl.selectedSegmentIndex
        setTipText(percentage_index)
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setObject( NSDate(), forKey: "eddited_time")
        defaults.setObject(billingTextField.text, forKey: "billing_ammount")
        defaults.synchronize()
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func setTipText(percentageIndex: Int) {
        let tipPercentages = [0.18, 0.2, 0.22]
        let tipPercentage = tipPercentages[percentageIndex]
        let billAmount = NSString(string: billingTextField.text!).doubleValue
        let people = countStepper.value
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        let payment = total/people
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        
        tipLabel.text = formatter.stringFromNumber(tip)
        totalLabel.text = formatter.stringFromNumber(total)
        paymentLabel.text = formatter.stringFromNumber(payment)
    }
    @IBAction func stepperChanged(sender: UIStepper) {
        peopleCount.text = "\(Int(countStepper.value))"
        let percentage_index = tipControl.selectedSegmentIndex
        setTipText(percentage_index)
    }
}

