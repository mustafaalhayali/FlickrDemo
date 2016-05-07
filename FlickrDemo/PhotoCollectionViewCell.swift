//
//  PhotoCollectionViewCell.swift
//  FlickrDemo
//
//  Created by Mustafa Al-Hayali on 2016-05-07.
//  Copyright © 2016 Mustafa Al-Hayali. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var spinner : UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateCellImageView(nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        updateCellImageView(nil)
    }
    
    func updateCellImageView(image : UIImage?){
        if let imageToDisplay = image {
            spinner.stopAnimating()
            imageView.image = imageToDisplay
        }else{
            spinner.startAnimating()
            imageView.image = nil
        }
    }
}
