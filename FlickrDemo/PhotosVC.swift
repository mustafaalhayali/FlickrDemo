//
//  PhotosVC.swift
//  FlickrDemo
//
//  Created by Mustafa Al-Hayali on 2016-05-06.
//  Copyright © 2016 Mustafa Al-Hayali. All rights reserved.
//

import UIKit

class PhotosVC: UIViewController {
    
    @IBOutlet var imageView : UIImageView!
    
    var photosHandler : PhotoHandler!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photosHandler = PhotoHandler()
        photosHandler.fetchRecentPhotos{(PhotoResult) -> Void in
            switch PhotoResult{
            case let .Success(photos):
                print("retrieved \(photos.count) photos")
                if let firstPhoto = photos.first{
                    self.photosHandler.fetchImageFromPhoto(firstPhoto, completion: { (imageResult) in
                        switch imageResult{
                        case let .Success(image):
                            NSOperationQueue.mainQueue().addOperationWithBlock({ 
                                self.imageView.image = image
                            })
                        case let .Failure(error):
                            print("error downloading the image from Flickr :\(error)")
                        }
                    })
                }
            case let .Failure(error):
                print("error : \(error)")
            }
        }
    }
}
