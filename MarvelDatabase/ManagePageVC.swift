//
//  PageVC.swift
//  MarvelDatabase
//
//  Created by Piotr Furmanski on 07.06.2016.
//  Copyright © 2016 Piotr Furmanski. All rights reserved.
//

import UIKit

class ManagePageViewController: UIPageViewController {
    var photos: [Int:UIImage] = [:]
    var currentIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        // 1
        if let viewController = viewPhotoController(currentIndex ?? 0) {
            let viewControllers = [viewController]
            // 2
            setViewControllers(
                viewControllers,
                direction: .Forward,
                animated: false,
                completion: nil
            )
        }
    }
    
    func viewPhotoController(index: Int) -> BigScreenShotVC? {
        if let storyboard = storyboard,
            page = storyboard.instantiateViewControllerWithIdentifier("BigScreenController")
                as? BigScreenShotVC {
            page.screen = photos[index]!
            page.photoIndex = index
            return page
        }
        return nil
    }
}

//MARK: implementation of UIPageViewControllerDataSource
extension ManagePageViewController: UIPageViewControllerDataSource {
    // 1
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? BigScreenShotVC {
            var index = viewController.photoIndex
            guard index != NSNotFound && index != 0 else { return nil }
            index = index - 1
            return viewPhotoController(index)
        }
        return nil
    }
    
    // 2
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? BigScreenShotVC {
            var index = viewController.photoIndex
            guard index != NSNotFound else { return nil }
            index = index + 1
            guard index != photos.count else {return nil}
            return viewPhotoController(index)
        }
        return nil
    }
    
    // MARK: UIPageControl
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return photos.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return currentIndex ?? 0
    }
}
