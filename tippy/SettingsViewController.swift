//
//  SettingsViewController.swift
//  tippy
//
//  Created by Gaspard on 8/20/17.
//  Copyright © 2017 vanko. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    static let KEY_PERCENT_1 = "tip_percent_1"
    static let KEY_PERCENT_2 = "tip_percent_2"
    static let KEY_PERCENT_3 = "tip_percent_3"
    
    @IBOutlet weak var labelPercent1: UILabel!
    @IBOutlet weak var labelPercent2: UILabel!
    @IBOutlet weak var labelPercent3: UILabel!
    
    let settings = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let percentages = SettingsViewController.getPercentages(settings)

        labelPercent1.text = SettingsViewController.formatPercentage(percentages[0])
        labelPercent2.text = SettingsViewController.formatPercentage(percentages[1])
        labelPercent3.text = SettingsViewController.formatPercentage(percentages[2])
    }
    
    static func getPercentages(_ settings: UserDefaults) -> [Int] {
        if (settings.object(forKey: SettingsViewController.KEY_PERCENT_1) == nil) {
            initSettings(settings)
        }
        
        let percent1 = settings.integer(
            forKey: SettingsViewController.KEY_PERCENT_1)
        let percent2 = settings.integer(
            forKey: SettingsViewController.KEY_PERCENT_2)
        let percent3 = settings.integer(
            forKey: SettingsViewController.KEY_PERCENT_3)
        
        return [percent1, percent2, percent3]
    }
    
    static func initSettings(_ settings: UserDefaults) {
        settings.set(15, forKey: SettingsViewController.KEY_PERCENT_1)
        settings.set(18, forKey: SettingsViewController.KEY_PERCENT_2)
        settings.set(22, forKey: SettingsViewController.KEY_PERCENT_3)
        settings.synchronize()
    }

    static func formatPercentage(_ percent: Int) -> String {
        return String(format: "%i%%", percent)
    }
    
    func updateSettingValue(_ key: String, delta: Int, label: UILabel) {
        let current = settings.integer(forKey: key)
        let new = current + delta
        settings.set(new, forKey: key)
        
        let animation = CATransition()
        animation.isRemovedOnCompletion = true
        animation.duration = 0.2
        animation.type = kCATransitionPush
        animation.subtype = new > current ? kCATransitionFromRight : kCATransitionFromLeft
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        label.layer.add(animation, forKey:"changeTextTransition")

        label.text = SettingsViewController.formatPercentage(new)
    }

    @IBAction func dec1(_ sender: Any) {
        updateSettingValue(SettingsViewController.KEY_PERCENT_1, delta: -1, label: labelPercent1)
    }
    
    @IBAction func inc1(_ sender: Any) {
        updateSettingValue(SettingsViewController.KEY_PERCENT_1, delta: 1, label: labelPercent1)
    }
    
    @IBAction func dec2(_ sender: Any) {
        updateSettingValue(SettingsViewController.KEY_PERCENT_2, delta: -1, label: labelPercent2)
    }
    
    @IBAction func inc2(_ sender: Any) {
        updateSettingValue(SettingsViewController.KEY_PERCENT_2, delta: 1, label: labelPercent2)
    }
    
    @IBAction func dec3(_ sender: Any) {
        updateSettingValue(SettingsViewController.KEY_PERCENT_3, delta: -1, label: labelPercent3)
    }
    
    @IBAction func inc3(_ sender: Any) {
        updateSettingValue(SettingsViewController.KEY_PERCENT_3, delta: 1, label: labelPercent3)
    }
}
