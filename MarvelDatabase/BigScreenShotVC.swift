//
//  BigScreenShotVC.swift
//  MarvelDatabase
//
//  Created by Piotr Furmanski on 09.03.2016.
//  Copyright © 2016 Piotr Furmanski. All rights reserved.
//

import UIKit

class BigScreenShotVC: UIViewController {

    @IBOutlet weak var image: UIImageView!
    var screen = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = screen
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
