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
    private(set) var vScreensUrl = [String]()
    
    // This variable gets created from the UI
    var vImageData:NSData?
    
    init(data: JSONDictionary) {
        
        if let id = data["id"] as? Int {
            vId = id
        } else {
            vId = -1
        }
        
        if let name = data["title"] as? String {
            self.vTitle = name
        } else {
            
            vTitle = ""
        }
        
        if let name = data["description"] as? String {
            self.vDescription = name
        } else {
            
            vDescription = ""
        }
        
        
        if let image = data["thumbnail"] as? JSONDictionary,
            path = image["path"] as? String,
            pathExtension = image["extension"] as? String{
                vImageUrl = path + "." + pathExtension
        } else {
            vImageUrl = ""
        }
        
        if let screenArray = data["images"] as? JSONArray {
            for screenDictionary in screenArray {
                if let screen = screenDictionary as? JSONDictionary,
                path = screen["path"] as? String,
                pathExtension = screen["extension"] as? String {
                    let screenUrl = path + pathExtension
                    vScreensUrl.append(screenUrl)
                }
            }
        }
        
    }
    
}