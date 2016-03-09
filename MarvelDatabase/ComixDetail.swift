//
//  ComixDetail.swift
//  MarvelDatabase
//
//  Created by Piotr Furmanski on 08.03.2016.
//  Copyright © 2016 Piotr Furmanski. All rights reserved.
//

import UIKit

class ComixDetail: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var comixTitle: UILabel!
    @IBOutlet weak var comixThumb: UIImageView!
    @IBOutlet weak var comixDescription: UILabel!
    
    var comix : Comix?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let comic = comix {
            comixTitle.text = comic.vTitle
            comixDescription.text = comic.vDescription
        }
        
        self.collectionView.backgroundColor = UIColor.clearColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("comixScreenCell", forIndexPath: indexPath) as? ComixScreenCell {
            
            if let url = comix?.vScreensUrl[indexPath.row] {
                cell.screenUrl = url
            }
            
            return cell
            
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        //let comic: Comix!
        //comic = comics[indexPath.row]
        
        
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(comix?.vScreensUrl.count)
        if let screenTable = comix?.vScreensUrl {
            return screenTable.count
        } else {
            return 0
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(105, 105)
    }
    
    
}
