//
//  PhotoDetailsVC.swift
//  FlickrDemo
//
//  Created by Mustafa Al-Hayali on 2016-05-07.
//  Copyright © 2016 Mustafa Al-Hayali. All rights reserved.
//

import UIKit

class PhotoDetailsVC: UIViewController {

    @IBOutlet var imageView : UIImageView!
    
    var photo : Photo!{
        didSet{
            navigationItem.title = photo.title
        }
    }
    
    var photoHandler : PhotoHandler!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoHandler = PhotoHandler()
        
        photoHandler.fetchImageFromPhoto(photo) { (result) in
            switch result {
            case let .Success(image):
                self.imageView.image = image
            case let .Failure(error):
                print("Error loading image : \(error)")
            }
        }
    }
    
}
