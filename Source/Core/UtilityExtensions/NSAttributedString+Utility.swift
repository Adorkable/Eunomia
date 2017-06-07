//
//  NSAttributedString+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import Foundation

extension NSAttributedString {
    
    // http://stackoverflow.com/a/21901056/96153
    convenience init(htmlString: String) throws {

        guard let data = htmlString.data() else {
            throw NSError(description: "Failed to create \(type(of: self))", underlyingError: NSError(description: "Unable to translate htmlString into NSData"))
        }
        
        let options : [String : AnyObject] = [
            NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType as AnyObject,
            NSCharacterEncodingDocumentAttribute : String.Encoding.utf8 as AnyObject
        ]
        
        try self.init(data: data as Data, options: options, documentAttributes: nil)
    }
}
