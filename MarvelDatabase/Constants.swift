//
//  Constants.swift
//  MarvelDatabase
//
//  Created by Piotr Furmanski on 02.03.2016.
//  Copyright © 2016 Piotr Furmanski. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: AnyObject]

typealias JSONArray = Array<AnyObject>

let PRIV_KEY = "731d1c334c639b0a6fff04df067252f3eae9e638"
let API_KEY = "981f2d139f0ae62191c5c39c3e34c89f"
let MARVEL_URL = "http://gateway.marvel.com:80/v1/public/characters?orderBy=name&limit=10&apikey="
let COMIX_URL = "http://gateway.marvel.com:80/v1/public/characters/"
let API_POSTFIX = "/comics?apikey="