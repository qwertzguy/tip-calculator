//
//  MainViewController.swift
//  tippy
//
//  Created by Gaspard on 8/17/17.
//  Copyright © 2017 vanko. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalPerPersLabel: UILabel!
    @IBOutlet weak var totalPerPersTextLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var personControl: UISegmentedControl!
    
    var tipPercentages: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTipSegment()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTipSegment()
        billField.becomeFirstResponder()
    }

    func fadeAndRevealIfNeeded(_ label: UILabel, viewShownToHidden: Bool) {
        if ((label.text == " " && !viewShownToHidden) || label.text != " " && viewShownToHidden) {
            let animation = CATransition()
            animation.isRemovedOnCompletion = true
            animation.duration = 0.2
            animation.type = kCATransitionPush
            animation.subtype = viewShownToHidden ? kCATransitionFromBottom : kCATransitionFromTop
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            label.layer.add(animation, forKey:"changeTextTransition")
        }
    }
    
    func updateTipSegment() {
        tipPercentages = SettingsViewController.getPercentages(UserDefaults.standard)
        
        tipControl.setTitle(SettingsViewController.formatPercentage(tipPercentages[0]), forSegmentAt: 0)
        tipControl.setTitle(SettingsViewController.formatPercentage(tipPercentages[1]), forSegmentAt: 1)
        tipControl.setTitle(SettingsViewController.formatPercentage(tipPercentages[2]), forSegmentAt: 2)
        
        calculateTip()
    }
    
    func flipAndUpdateIfNeeded(_ label: UILabel, _ newText: String) {
        if (label.text != newText) {
            UIView.transition(with: label,
                              duration: 0.25,
                              options: .transitionFlipFromTop,
                              animations: {
                                label.text = newText
                }, completion: nil)
        }
    }

    @IBAction func calculateTip() {
        let bill = Double(billField.text!) ?? 0
        let numberPers = personControl.selectedSegmentIndex + 1
        let tip = bill * Double(tipPercentages[tipControl.selectedSegmentIndex]) * 0.01
        let total = bill + tip
        let totalPerPers = total / Double(numberPers)
        
        let tipText = formatAmount(tip)
        flipAndUpdateIfNeeded(tipLabel, tipText)

        let totalText = formatAmount(total)
        flipAndUpdateIfNeeded(totalLabel, totalText)

        fadeAndRevealIfNeeded(totalPerPersLabel, viewShownToHidden: numberPers == 1)
        fadeAndRevealIfNeeded(totalPerPersTextLabel, viewShownToHidden: numberPers == 1)
        if (numberPers > 1) {
            totalPerPersLabel.text = formatAmount(totalPerPers)
            totalPerPersTextLabel.text = "Total per person"
        } else {
            totalPerPersLabel.text = " "
            totalPerPersTextLabel.text = " "
        }
    }
    
    func formatAmount(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: amount))!
    }
}

