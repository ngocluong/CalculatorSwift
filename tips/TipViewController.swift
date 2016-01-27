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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
    }
    
    override func viewWillAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let defaultPercentageIndex = defaults.integerForKey("default_tip_percentage")
        tipControl.selectedSegmentIndex = defaultPercentageIndex
        setTipText(defaultPercentageIndex)
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        let percentage_index = tipControl.selectedSegmentIndex
        setTipText(percentage_index)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func setTipText(percentageIndex: Int) {
        let tipPercentages = [0.18, 0.2, 0.22]
        let tipPercentage = tipPercentages[percentageIndex]
        let billAmount = NSString(string: billingTextField.text!).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
}

