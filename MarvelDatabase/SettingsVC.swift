//
//  SettingsVC.swift
//  MarvelDatabase
//
//  Created by Piotr Furmanski on 10.03.2016.
//  Copyright © 2016 Piotr Furmanski. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Settings"
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("charactersNumber") != nil)
        {
            let theValue = NSUserDefaults.standardUserDefaults().objectForKey("charactersNumber") as! Int
            numberLabel.text = String(theValue)
            slider.value = Float(theValue)
        } else {
            slider.value = 5.0
            numberLabel.text = String(Int(slider.value))
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func sliderChangedValue(sender: UISlider) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(Int(slider.value), forKey: "charactersNumber")
        defaults.setBool(true, forKey: "numberChanged")
        numberLabel.text = String(Int(slider.value))
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
