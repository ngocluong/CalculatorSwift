//
//  SettingsViewController.swift
//  tips
//
//  Created by luong ngoc on 1/27/16.
//  Copyright © 2016 luong ngoc. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var defaultLabel: UILabel!
    @IBOutlet weak var darkThemeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let defaultPercentageIndex = defaults.integerForKey("default_tip_percentage")
        defaultTipControl.selectedSegmentIndex = defaultPercentageIndex
        darkThemeLabel.textColor = UIColor.whiteColor()
        defaultLabel.textColor = UIColor.whiteColor()
        defaultTipControl.tintColor = UIColor.whiteColor()
        
        let darkTheme = defaults.boolForKey("dark_theme")
        themeSwitch.setOn(darkTheme, animated: true)
        setTheme(darkTheme)
    }
    
    
    @IBAction func onSegmentChanged(sender: UISegmentedControl) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setObject(defaultTipControl.selectedSegmentIndex, forKey: "default_tip_percentage")
        defaults.synchronize()
    }

    @IBAction func onSwitchChanged(sender: UISwitch) {
        let defaults = NSUserDefaults.standardUserDefaults()

        defaults.setBool(themeSwitch.on, forKey: "dark_theme")
        defaults.synchronize()
        setTheme(themeSwitch.on)
    }
    
    func setTheme(darkTheme: Bool) {
        if darkTheme {
            topView.backgroundColor = UIColor(red: 13/225, green: 48/225, blue: 93/225, alpha: 1)
            view.backgroundColor = UIColor(red: 5/225, green: 33/225, blue: 70/225, alpha: 1)
        } else {
            topView.backgroundColor = UIColor(red: 114/225, green: 163/225, blue: 225/225, alpha: 1)
            view.backgroundColor = UIColor(red: 74/225, green: 136/225, blue: 215/225, alpha: 1)
        }
    }
}
