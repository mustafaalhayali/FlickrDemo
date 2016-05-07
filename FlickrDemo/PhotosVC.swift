//
//  PhotosVC.swift
//  FlickrDemo
//
//  Created by Mustafa Al-Hayali on 2016-05-06.
//  Copyright © 2016 Mustafa Al-Hayali. All rights reserved.
//

import UIKit

class PhotosVC: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var photosHandler : PhotoHandler!
    let photosDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosHandler = PhotoHandler()
        collectionView.dataSource = photosDataSource
        collectionView.delegate = self
        
        photosHandler.fetchRecentPhotos{(PhotoResult) -> Void in
            NSOperationQueue.mainQueue().addOperationWithBlock({ 
                switch PhotoResult{
                case let .Success(photos):
                    print("retrieved \(photos.count) photos")
                    self.photosDataSource.photos = photos
                case let .Failure(error):
                    self.photosDataSource.photos.removeAll()
                    print("error retrieving the images : \(error)")
                }
                self.collectionView.reloadSections(NSIndexSet(index: 0))
            })
        }
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let photo = photosDataSource.photos[indexPath.row]
        
        photosHandler.fetchImageFromPhoto(photo) { (result) in
            NSOperationQueue.mainQueue().addOperationWithBlock({ 
                let photoIndex = self.photosDataSource.photos.indexOf(photo)!
                let photoIndexPath = NSIndexPath(forRow: photoIndex, inSection: 0)
                if let cell = self.collectionView.cellForItemAtIndexPath(photoIndexPath) as? PhotoCollectionViewCell{
                    cell.updateCellImageView(photo.image)
                }                
            })
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPhoto"{
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems()?.first{
                let photo = photosDataSource.photos[selectedIndexPath.row]
                let destinationVC = segue.destinationViewController as! PhotoDetailsVC
                destinationVC.photo = photo
                destinationVC.photoHandler = photosHandler
            }
            
        }
    }
        
}
