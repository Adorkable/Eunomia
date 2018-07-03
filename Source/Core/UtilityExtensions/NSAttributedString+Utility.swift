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
        
        try self.init(data: data as Data, options: [
            .documentType : NSAttributedString.DocumentType.html as AnyObject,
            .characterEncoding : String.Encoding.utf8 as AnyObject
            ], documentAttributes: nil)
    }
}

extension NSAttributedString {
    // https://stackoverflow.com/a/30450559
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
}
