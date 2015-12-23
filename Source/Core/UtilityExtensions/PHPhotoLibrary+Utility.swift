//
//  PHPhotoLibrary+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 12/1/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import Photos

extension PHPhotoLibrary {
    
    public enum RetrieveFirstImageResult {
        case Success(UIImage)
        case NoImages
        case Denied(PHAuthorizationStatus)
        case Error(NSError)
    }
    public func retrieveFirstImage(requestAuthorizationIfNeeded requestAuthorizationIfNeeded : Bool = true, completion completionHandler : (RetrieveFirstImageResult) -> Void) {

        let retrieve = { () -> Void in
            let collections = PHAssetCollection.fetchAssetCollectionsWithType(.SmartAlbum, subtype: .SmartAlbumUserLibrary, options: nil)
            
            guard collections.count > 0 else {
                completionHandler(.NoImages)
                return
            }
            
            guard let collection = collections.firstObject as? PHAssetCollection else {
                
                let error = NSError(description: "Expected to be given a \(PHAssetCollection.self), instead given a \(collections.firstObject?.dynamicType)")
                completionHandler(.Error(error))
                return
            }
            
            // TODO: test that our collection is Camera Roll
            let cameraRoll = collection

            let options = PHFetchOptions()
            options.predicate = NSPredicate(format: "mediaType == %d", PHAssetMediaType.Image.rawValue)
            options.includeAssetSourceTypes = PHAssetSourceType.TypeUserLibrary
            options.fetchLimit = 1
            options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

            let assets = PHAsset.fetchAssetsInAssetCollection(cameraRoll, options: options)
            guard assets.count > 0 else {
                completionHandler(.NoImages)
                return
            }
            
            guard let asset = assets.firstObject as? PHAsset else {
                
                let error = NSError(description: "Expected to be given a \(PHAsset.self), instead given a \(assets.firstObject?.dynamicType)")
                completionHandler(.Error(error))
                return
            }
            
            let imageManager : PHImageManager = PHImageManager()
            imageManager.requestImageDataForAsset(asset, options: nil, resultHandler: { (data, dataUTI, orientation, info) -> Void in
                
                guard let data = data else {
                    completionHandler(.NoImages)
                    return
                }
                
                guard let photo = UIImage(data: data) else {
                    
                    let error = NSError(description: "Unable to create UIImage from data")
                    completionHandler(.Error(error))
                    return
                }

                completionHandler(.Success(photo))
            })
        }
        
        switch PHPhotoLibrary.authorizationStatus() {
        case .Authorized:
            retrieve()
            break
            
        case .NotDetermined:
            if requestAuthorizationIfNeeded == true {
                PHPhotoLibrary.requestAuthorization(self.requestAuthorizationToRetrieveFirstImageHandler(completion: completionHandler))
            } else {
                completionHandler(.Denied(.NotDetermined))
            }
            break

        case .Restricted:
            completionHandler(.Denied(.Restricted))
            break
            
        case .Denied:
            completionHandler(.Denied(.Denied))
            break
        }

    }
    
    private func requestAuthorizationToRetrieveFirstImageHandler(completion completionHandler : (RetrieveFirstImageResult) -> Void) -> ( (PHAuthorizationStatus) -> Void) {
        
        return { (result) -> Void in
            
            // We're checking authorization status in retrieveFirstImage already, let's reuse our code but not re-request authorization
            self.retrieveFirstImage(requestAuthorizationIfNeeded: false, completion: completionHandler)
        }
    }
}