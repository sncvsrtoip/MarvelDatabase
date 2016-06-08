//
//  ComixCell.swift
//  MarvelDatabase
//
//  Created by Piotr Furmanski on 08.03.2016.
//  Copyright © 2016 Piotr Furmanski. All rights reserved.
//

import UIKit

class ComixCell: UICollectionViewCell {

    @IBOutlet weak var comixTitle: UILabel!
    @IBOutlet weak var comixImage: UIImageView!
    
    var comix: Comix? {
        didSet {
            updateCell()
        }
    }
    
    func updateCell() {
        
        comixTitle.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
        comixTitle.text = comix!.vTitle
        
        if comix!.vImageData != nil {
            comixImage.image = UIImage(data: comix!.vImageData!)
        } else {
            getComixImage(comix!, imageView: comixImage)
        }
        
        
    }
    
    func getComixImage(comix: Comix, imageView : UIImageView){
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            let data = NSData(contentsOfURL: NSURL(string: comix.vImageUrl)!)
            
            var image : UIImage?
            if data != nil {
                comix.vImageData = data
                image = UIImage(data: data!)
            }
            // move back to Main Queue
            dispatch_async(dispatch_get_main_queue()) {
                if self.comix?.vTitle == comix.vTitle {
                    imageView.image = image
                }
            }
        }
    }


}
