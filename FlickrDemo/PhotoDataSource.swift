//
//  PhotoDataSource.swift
//  FlickrDemo
//
//  Created by Mustafa Al-Hayali on 2016-05-07.
//  Copyright © 2016 Mustafa Al-Hayali. All rights reserved.
//

import UIKit

class PhotoDataSource: NSObject, UICollectionViewDataSource {
    
    var photos = [Photo]()
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = "uicollectionviewcell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! PhotoCollectionViewCell
        
        let photo = photos[indexPath.row]
        cell.updateCellImageView(photo.image)
        
        return cell
    }

}
