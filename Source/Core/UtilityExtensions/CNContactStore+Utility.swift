//
//  CNContactStore+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import Foundation

import Contacts

@available(iOS 9.0, *)
extension CNContactStore {

    // TODO: SuccessResult?
    public class func requestAccessToContacts(_ completion: ((_ granted : Bool, _ error : Error?) -> Void)?) {
        let contactStore = CNContactStore()
        
        contactStore.requestAccess(for: CNEntityType.contacts) { (granted, error) -> Void in

            if let completion = completion
            {
                completion(granted, error)
            }
        }
    }
}
