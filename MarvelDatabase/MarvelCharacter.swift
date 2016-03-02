//
//  MarvelCharacter.swift
//  MarvelDatabase
//
//  Created by Piotr Furmanski on 02.03.2016.
//  Copyright © 2016 Piotr Furmanski. All rights reserved.
//

import Foundation

class MarvelCharacter {
    
    // Data encapsulation
    private(set) var vName:String
    private(set) var vImageUrl:String
    
    // This variable gets created from the UI
    var vImageData:NSData?
    
    init(data: JSONDictionary) {
        
        // Video name
        if let name = data["name"] as? String {
                self.vName = name
        } else {
            
            vName = ""
        }
        
        
        // The Video Image
        if let img = data["thumbnail"] as? JSONDictionary,
            image = img["path"] as? String {
                vImageUrl = image + ".jpg"
        } else {
            vImageUrl = ""
        }
        
    }
    
}
