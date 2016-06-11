//
//  ComixVC.swift
//  MarvelDatabase
//
//  Created by Piotr Furmanski on 08.03.2016.
//  Copyright © 2016 Piotr Furmanski. All rights reserved.
//

import UIKit

class ComixVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var comics = [Comix]()
    var id : Int?
    var indexSelected : NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let charId = id {
            runComixAPI(charId)
        }
        self.collectionView.backgroundColor = UIColor.clearColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("comixCell", forIndexPath: indexPath) as? ComixCell {
            cell.comixImage.image = nil
            let comic: Comix!
            comic = comics[indexPath.row]
            
            cell.comix = comic
            
            return cell
            
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    func runComixAPI(id : Int) {
        //Call API
        let limit = 50
        let api = APIManager()
        let ts = String(NSDate().timeIntervalSince1970)
        let hash = md5(string: ts + PRIV_KEY + API_KEY)
        var url = COMIX_URL + String(id) + API_POSTFIX + API_KEY + AND_LIMIT + String(limit)
        url += "&ts="+ts+"&hash="+hash;
        api.loadData(url, completion: didLoadComixData)
    }
    
    func didLoadComixData(comics: [Comix]) {
        
        self.comics = comics
        collectionView.reloadData()
        indicator.stopAnimating()
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let comic : Comix!
        comic = comics[indexPath.row]
        indexSelected = indexPath
        
        performSegueWithIdentifier("ComixDetail", sender: comic)
        
        
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(comics.count)
        return comics.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        
//        return CGSizeMake(105, 105)
//    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ComixDetail" {
            if let comicDetailVC = segue.destinationViewController as? ComixDetail {
                if let comic = sender as? Comix {
                    comicDetailVC.comix = comic
                }
            }
        }
    }

}
