//
//  ViewController.swift
//  MarvelDatabase
//
//  Created by Piotr Furmanski on 25.02.2016.
//  Copyright © 2016 Piotr Furmanski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout, UISearchBarDelegate {


    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var marvelCharacters = [MarvelCharacter]()
    var marvelFilteredCharacters = [MarvelCharacter]()
    var inSearchMode = false

    var comics = [Comix]()
    var limit = LIMIT
    var letter = LETTER
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged), name: "ReachStatusChanged", object: nil)
        
        reachabilityStatusChanged()
        
        runAPI()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if let changed = NSUserDefaults.standardUserDefaults().objectForKey("numberChanged") as? Bool
            where changed == true  {
            
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setBool(false, forKey: "numberChanged")
                
                runAPI()
                
        } else if let changed = NSUserDefaults.standardUserDefaults().objectForKey("letterChanged") as? Bool
            where changed == true  {
                
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setBool(false, forKey: "letterChanged")
                
                runAPI()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func runAPI() {
        
        getNumberOfCharactersPerLetter()
        getFirstLetterOfCharacters()
        
        //Call API
        let api = APIManager()
        let ts = String(NSDate().timeIntervalSince1970)
        let hash = md5(string: ts + PRIV_KEY + API_KEY)
        
        var url = MARVEL_URL + letter + AND_LIMIT + String(limit) + AND_API + API_KEY
        url += "&ts="+ts+"&hash="+hash;
        api.loadData(url, completion: didLoadData)
        
    }
    
    func getNumberOfCharactersPerLetter() {
        if (NSUserDefaults.standardUserDefaults().objectForKey("charactersNumber") != nil) {
            let theValue = NSUserDefaults.standardUserDefaults().objectForKey("charactersNumber") as! Int
            limit = theValue
        }
    }
    
    func getFirstLetterOfCharacters() {
        if (NSUserDefaults.standardUserDefaults().objectForKey("charactersLetter") != nil) {
            let theValue = NSUserDefaults.standardUserDefaults().objectForKey("charactersLetter") as! String
            letter = theValue
        }
    }
    
    func didLoadData(marvelCharacters: [MarvelCharacter]) {
        let sortedMarveCharacters = marvelCharacters.sort {$0.vName.compare($1.vName) == .OrderedAscending }
        self.marvelCharacters = sortedMarveCharacters
        
        collectionView.reloadData()
        indicator.stopAnimating()
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("marvelCell", forIndexPath: indexPath) as? MarvelCell {
            
            let mCharacter: MarvelCharacter!
            
            if inSearchMode {
                mCharacter = marvelFilteredCharacters[indexPath.row]
            } else {
                mCharacter = marvelCharacters[indexPath.row]
            }
            
            cell.mCharacter = mCharacter

            return cell
            
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let mCharacter : MarvelCharacter!
        
        if inSearchMode {
        mCharacter = marvelFilteredCharacters[indexPath.row]
        } else {
            mCharacter = marvelCharacters[indexPath.row]
        }
    
        performSegueWithIdentifier("CharacterDetail", sender: mCharacter)
        
        
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return marvelFilteredCharacters.count
        }
        return marvelCharacters.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(105, 105)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            collectionView.reloadData()
        } else {
            inSearchMode = true
            let searchedCharacter = searchBar.text!.lowercaseString
            
            marvelFilteredCharacters = marvelCharacters.filter { marvelCharacters in
                return marvelCharacters.vName.lowercaseString.containsString(searchedCharacter.lowercaseString)
                
            }
            collectionView.reloadData()
        }
    }
    
    func reachabilityStatusChanged() {
        switch reachabilityStatus {
        case NOACCESS :
            dispatch_async(dispatch_get_main_queue()) {
                let alert = UIAlertController(title: "No Internet Access", message: "Please make sure you are connected to the internet", preferredStyle: .Alert)
                
                let okAction = UIAlertAction(title: "Ok", style: .Default, handler: { (action) -> Void in
                })
                
                alert.addAction(okAction)
                
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
        default :
            if marvelCharacters.count > 0 {
            } else {
                runAPI()
            }
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CharacterDetail" {
            if let comicVC = segue.destinationViewController as? ComixVC {
                if let character = sender as? MarvelCharacter {
                    comicVC.id = character.vId
                }
            }
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }

}

