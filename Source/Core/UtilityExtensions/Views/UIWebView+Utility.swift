//
//  UIWebView+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

#if os(iOS)
import UIKit

import JavaScriptCore

extension UIWebView {
    
    public var jsContext : JSContext? {
        return self.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as? JSContext
    }
    
    public func loadFullCanvasHTML() {
        let html =
                "<!DOCTYPE html>\n" +
                "<html>\n" +
                "   <head>\n" +
                "       <style>\n" +
                "           body {\n" +
                "               margin: 0;\n" +
                "               text-align: center;\n" +
                "           }\n" +
                "       </style>\n" +
                "   </head>\n" +
                "   <body>\n" +
                "       <canvas id=\'canvas\' width=\'%d\' height=\'%d\'>\nCanvas not supported\n" +
                "       </canvas>\n" +
                "   </body>\n" +
                "</html>"
        
        self.loadHTMLString(html, baseURL: nil)
    }
}
#endif
