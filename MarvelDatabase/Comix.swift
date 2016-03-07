//
//  Comix.swift
//  MarvelDatabase
//
//  Created by Piotr Furmanski on 08.03.2016.
//  Copyright © 2016 Piotr Furmanski. All rights reserved.
//

import Foundation

class Comix {
    
    // Data encapsulation
    private(set) var vId:Int
    private(set) var vTitle:String
    private(set) var vImageUrl:String
    private(set) var vDescription:String
    
    // This variable gets created from the UI
    var vImageData:NSData?
    
    init(data: JSONDictionary) {
        
        if let id = data["id"] as? Int {
            vId = id
        } else {
            vId = -1
        }
        
        if let name = data["name"] as? String {
            self.vTitle = name
        } else {
            
            vTitle = ""
        }
        
        if let name = data["description"] as? String {
            self.vDescription = name
        } else {
            
            vDescription = ""
        }
        
        
        if let img = data["thumbnail"] as? JSONDictionary,
            image = img["path"] as? String {
                vImageUrl = image + ".jpg"
        } else {
            vImageUrl = ""
        }
        
    }
    
}