//
//  PhotoHandler.swift
//  FlickrDemo
//
//  Created by Mustafa Al-Hayali on 2016-05-06.
//  Copyright © 2016 Mustafa Al-Hayali. All rights reserved.
//

import UIKit

class PhotoHandler{
    
    let session : NSURLSession = {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        return NSURLSession(configuration: config)
    }()
    
    func fetchRecentPhotos(completion completion: (PhotoResult) -> Void){
        let url = FlickrAPI.recentPhotosURLBuilder()
        let request = NSURLRequest(URL: url)
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
           let result = self.processRecentPhotosRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    
    private func processRecentPhotosRequest(data data: NSData?, error: NSError?)-> PhotoResult{
        guard let jsonData = data else{
            return .Failure(error!)
        }
        return FlickrAPI.photosFromJSONData(jsonData)
    }
    
    func fetchImageFromPhoto(photo : Photo, completion : (ImageResult) -> Void){
        let photoURL = photo.remoteURL
        let request = NSURLRequest(URL: photoURL)
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            let result = self.processImageRequest(data: data, error: error)
            
            switch result{
            case let .Success(image):
                photo.image = image
            case .Failure(_):
                break
            }
            
            completion(result)
        }
        task.resume()
    }
    
    func processImageRequest(data data : NSData?, error : NSError?) -> ImageResult{
        guard let imageData = data, image = UIImage(data: imageData) else {
            if data == nil{
                return .Failure(error!)
            }else{
                return .Failure(PhotoError.ImageCreationError)
            }
        }
        return .Success(image)
    }
}
enum ImageResult {
    case Success(UIImage)
    case Failure(ErrorType)
}

enum PhotoError : ErrorType{
    case ImageCreationError
}