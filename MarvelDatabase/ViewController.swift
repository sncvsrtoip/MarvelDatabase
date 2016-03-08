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
    var marvelCharacters = [MarvelCharacter]()
    var comics = [Comix]()
    
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
        let mCharacter : MarvelCharacter!
        mCharacter = marvelCharacters[indexPath.row]
    
        performSegueWithIdentifier("ComixDetailVC", sender: mCharacter)
        
        
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ComixDetailVC" {
            if let comicVC = segue.destinationViewController as? ComixVC {
                if let character = sender as? MarvelCharacter {
                    comicVC.id = character.vId
                }
            }
        }
    }

}

