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
            throw NSError(description: "Failed to create \(self.dynamicType)", underlyingError: NSError(description: "Unable to translate htmlString into NSData"))
        }
        
        let options : [String : AnyObject] = [
            NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute : NSUTF8StringEncoding
        ]
        
        try self.init(data: data, options: options, documentAttributes: nil)
    }
}