//
//  PhotoModel.swift
//  FlickrDemo
//
//  Created by Mustafa Al-Hayali on 2016-05-06.
//  Copyright © 2016 Mustafa Al-Hayali. All rights reserved.
//

import UIKit

class Photo {
    let title : String
    let photoID : String
    let remoteURL : NSURL
    let dateTaken : NSDate
    var image : UIImage?
    
    init(title: String, photoID: String, remoteURL: NSURL, dateTaken: NSDate) {
        self.title = title
        self.photoID = photoID
        self.remoteURL = remoteURL
        self.dateTaken = dateTaken
    }
}
