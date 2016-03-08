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
    private(set) var vId:Int
    private(set) var vName:String
    private(set) var vImageUrl:String
    
    // This variable gets created from the UI
    var vImageData:NSData?
    
    init(data: JSONDictionary) {
        
        if let id = data["id"] as? Int {
            vId = id
        } else {
            vId = -1
        }
        
        if let name = data["name"] as? String {
                self.vName = name
        } else {
            
            vName = ""
        }
        

        if let img = data["thumbnail"] as? JSONDictionary,
            image = img["path"] as? String,
            imageExtension = img["extension"] as? String {
                vImageUrl = image + "." + imageExtension
        } else {
            vImageUrl = ""
        }
        
    }
    
}
