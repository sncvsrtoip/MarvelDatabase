//
//  ViewController.swift
//  MarvelDatabase
//
//  Created by Piotr Furmanski on 25.02.2016.
//  Copyright © 2016 Piotr Furmanski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{


    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var tableView: UIView!
    var marvelCharacters = [MarvelCharacter]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        runAPI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func runAPI() {
        //Call API
        let api = APIManager()
        let ts = String(NSDate().timeIntervalSince1970)
        let hash = md5(string: ts + PRIV_KEY + API_KEY)
        var url = MARVEL_URL + API_KEY
        url += "&ts="+ts+"&hash="+hash;
        api.loadData(url, completion: didLoadData)
    }
    
    func didLoadData(marvelCharacters: [MarvelCharacter]) {
        
        self.marvelCharacters = marvelCharacters
        
//        for (index, item) in marvelCharacters.enumerate() {
//            print("\(index) name = \(item.vName)")
//        }
        
        collectionView.reloadData()
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("marvelCell", forIndexPath: indexPath) as? MarvelCell {
            
            let mCharacter: MarvelCharacter!
            mCharacter = marvelCharacters[indexPath.row]
            
            cell.mCharacter = mCharacter
            print(mCharacter.vImageUrl)

            return cell
            
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let mCharacter: MarvelCharacter!
        mCharacter = marvelCharacters[indexPath.row]
        
        
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(marvelCharacters.count)
        return marvelCharacters.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(105, 105)
    }
    
    func md5(string string: String) -> String {
        var digest = [UInt8](count: Int(CC_MD5_DIGEST_LENGTH), repeatedValue: 0)
        if let data = string.dataUsingEncoding(NSUTF8StringEncoding) {
            CC_MD5(data.bytes, CC_LONG(data.length), &digest)
        }
        
        var digestHex = ""
        for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        
        return digestHex
    }

}

