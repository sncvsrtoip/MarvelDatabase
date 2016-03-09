//
//  ApiManager.swift
//  MarvelDatabase
//
//  Created by Piotr Furmanski on 02.03.2016.
//  Copyright © 2016 Piotr Furmanski. All rights reserved.
//

import Foundation

class APIManager {
    
    var characters = [MarvelCharacter]()
    
    func loadData(urlString:String, completion: [MarvelCharacter] -> Void ) {
        
        //let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        //let session = NSURLSession(configuration: config)
        
        
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlString)!
        
        let task = session.dataTaskWithURL(url) {
            (data, response, error) -> Void in
            
            if error != nil {
                
                print(error!.localizedDescription)
                
                
            } else {
                
                do {
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? JSONDictionary,
                        data = json["data"] as? JSONDictionary,
                        results = data["results"] as? JSONArray {
                            
                            for entry in results {
                                let entry = MarvelCharacter(data: entry as! JSONDictionary)
                                self.characters.append(entry)
                            }

                            let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                                dispatch_async(dispatch_get_main_queue()) {
                                    completion(self.characters)
                                }
                            }
                    }
                } catch {
                    print("error in NSJSONSerialization")
                    
                }
                
            }
        }
        
        task.resume()
    }
    
    func loadData(urlString:String, completion: [Comix] -> Void ) {
        
        
        //let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        //let session = NSURLSession(configuration: config)
        
        
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlString)!
        
        let task = session.dataTaskWithURL(url) {
            (data, response, error) -> Void in
            
            if error != nil {
                
                print(error!.localizedDescription)
                
                
            } else {
                
                do {
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? JSONDictionary,
                        data = json["data"] as? JSONDictionary,
                        results = data["results"] as? JSONArray {
                            
                            var comics = [Comix]()
                            for entry in results {
                                let entry = Comix(data: entry as! JSONDictionary)
                                comics.append(entry)
                            }
                            
                            let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                                dispatch_async(dispatch_get_main_queue()) {
                                    completion(comics)
                                }
                            }
                    }
                } catch {
                    print("error in NSJSONSerialization")
                    
                }
                
            }
        }
        
        task.resume()
    }

}