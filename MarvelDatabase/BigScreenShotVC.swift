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
    
    var screen: UIImage? = UIImage() {
        didSet {
            if let imageOutlet = image {
               imageOutlet.image = screen
            }
        }
    }
    var photoIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = screen
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
