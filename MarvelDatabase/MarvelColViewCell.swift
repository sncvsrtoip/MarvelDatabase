//
//  MarvelColViewCell.swift
//  MarvelDatabase
//
//  Created by Piotr Furmanski on 02.03.2016.
//  Copyright © 2016 Piotr Furmanski. All rights reserved.
//

import UIKit

class MarvelCell: UICollectionViewCell {
    
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var mCharacter: MarvelCharacter? {
        didSet {
            updateCell()
        }
    }
    
    func updateCell() {
        
        characterName.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
        characterName.text = mCharacter!.vName

        //musicImage.image = UIImage(named: "imageNotAvailable")
        
        if mCharacter!.vImageData != nil {
            imageView.image = UIImage(data: mCharacter!.vImageData!)
        } else {
            GetCharacterImage(mCharacter!, imageView: imageView)
        }
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 15.0
        imageView.clipsToBounds = true
        
    }
    
    func GetCharacterImage(character: MarvelCharacter, imageView : UIImageView){
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            let data = NSData(contentsOfURL: NSURL(string: character.vImageUrl)!)
            
            var image : UIImage?
            if data != nil {
                character.vImageData = data
                image = UIImage(data: data!)
            }

            // move back to Main Queue
            dispatch_async(dispatch_get_main_queue()) {
                if self.mCharacter?.vName == character.vName {
                    imageView.image = image
                }
            }
        }
    }
    
}
