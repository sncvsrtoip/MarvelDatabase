//
//  comixScreenCell.swift
//  MarvelDatabase
//
//  Created by Piotr Furmanski on 09.03.2016.
//  Copyright © 2016 Piotr Furmanski. All rights reserved.
//

import UIKit

class ComixScreenCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    var screenUrl: String? {
        didSet {
            updateCell()
        }
    }
    
    func updateCell() {
        getComixImage(screenUrl!, imageView: image)
    }
    
    func getComixImage(url: String, imageView : UIImageView){
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            let data = NSData(contentsOfURL: NSURL(string: url)!)
            
            var image : UIImage?
            if data != nil {
                image = UIImage(data: data!)
            }
            // move back to Main Queue
            dispatch_async(dispatch_get_main_queue()) {
                imageView.image = image
            }
        }
    }
}
