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
        case success(UIImage)
        case noImages
        case denied(PHAuthorizationStatus)
        case error(NSError)
    }
    public func retrieveFirstImage(requestAuthorizationIfNeeded : Bool = true, completion completionHandler : @escaping (RetrieveFirstImageResult) -> Void) {

        let retrieve = { () -> Void in
            let collections = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
            
            guard collections.count > 0 else {
                completionHandler(.noImages)
                return
            }
            
            guard let collection = collections.firstObject else {
                
                let error = NSError(description: "Expected to be given a \(PHAssetCollection.self), instead given a \(type(of: collections.firstObject))")
                completionHandler(.error(error))
                return
            }
            
            // TODO: test that our collection is Camera Roll
            let cameraRoll = collection

            let options = PHFetchOptions()
            options.predicate = NSPredicate(format: "mediaType == %d", PHAssetMediaType.image.rawValue)
            options.includeAssetSourceTypes = PHAssetSourceType.typeUserLibrary
            options.fetchLimit = 1
            options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

            let assets = PHAsset.fetchAssets(in: cameraRoll, options: options)
            guard assets.count > 0 else {
                completionHandler(.noImages)
                return
            }
            
            guard let asset = assets.firstObject else {
                
                let error = NSError(description: "Expected to be given a \(PHAsset.self), instead given a \(type(of: assets.firstObject))")
                completionHandler(.error(error))
                return
            }
            
            let imageManager : PHImageManager = PHImageManager()
            imageManager.requestImageData(for: asset, options: nil, resultHandler: { (data, dataUTI, orientation, info) -> Void in
                
                guard let data = data else {
                    completionHandler(.noImages)
                    return
                }
                
                guard let photo = UIImage(data: data) else {
                    
                    let error = NSError(description: "Unable to create UIImage from data")
                    completionHandler(.error(error))
                    return
                }

                completionHandler(.success(photo))
            })
        }
        
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            retrieve()
            break
            
        case .notDetermined:
            if requestAuthorizationIfNeeded == true {
                PHPhotoLibrary.requestAuthorization(self.requestAuthorizationToRetrieveFirstImageHandler(completion: completionHandler))
            } else {
                completionHandler(.denied(.notDetermined))
            }
            break

        case .restricted:
            completionHandler(.denied(.restricted))
            break
            
        case .denied:
            completionHandler(.denied(.denied))
            break
        }

    }
    
    fileprivate func requestAuthorizationToRetrieveFirstImageHandler(completion completionHandler : @escaping (RetrieveFirstImageResult) -> Void) -> ( (PHAuthorizationStatus) -> Void) {
        
        return { (result) -> Void in
            
            // We're checking authorization status in retrieveFirstImage already, let's reuse our code but not re-request authorization
            self.retrieveFirstImage(requestAuthorizationIfNeeded: false, completion: completionHandler)
        }
    }
}
