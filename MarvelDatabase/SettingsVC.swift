//
//  SettingsVC.swift
//  MarvelDatabase
//
//  Created by Piotr Furmanski on 10.03.2016.
//  Copyright © 2016 Piotr Furmanski. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var pickerOutlet: UIPickerView!
    
    let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    var alphabetArray = [Character]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings"
        
        alphabetArray = Array(alphabet.characters)
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("charactersNumber") != nil)
        {
            let theValue = NSUserDefaults.standardUserDefaults().objectForKey("charactersNumber") as! Int
            numberLabel.text = String(theValue)
            slider.value = Float(theValue)
        } else {
            slider.value = Float(LIMIT)
            numberLabel.text = String(Int(slider.value))
        }
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("charactersLetter") != nil)
        {
            let theValue = NSUserDefaults.standardUserDefaults().objectForKey("charactersLetter") as! String
            pickerOutlet.selectRow(alphabetArray.indexOf(Character(theValue))!, inComponent: 0, animated: true)
        } else {
            pickerOutlet.selectRow(alphabetArray.indexOf(Character(LETTER))!, inComponent: 0, animated: true)
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
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return alphabet.characters.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(alphabetArray[row])
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(String(alphabetArray[row]), forKey: "charactersLetter")
        defaults.setBool(true, forKey: "letterChanged")
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
