//
//  AppExtensionSafeApplication.swift
//  Eunomia
//
//  Created by Ian Grossberg on 6/27/19.
//  Copyright © 2019 Adorkable. All rights reserved.
//

import Foundation

// Based on https://github.com/heilerich/Gestalt/commit/259c4f2e3e0878e97ee2b98cad2610990a3e2f14
#if os(iOS)
public class AppExtensionSafeApplication {
    static var shared: UIApplication? {
        let sharedSelector = NSSelectorFromString("sharedApplication") // Whadda hack
        guard UIApplication.responds(to: sharedSelector) else {
            // Extensions cannot access UIApplication
            return nil
        }
        let shared = UIApplication.perform(sharedSelector)
        return shared?.takeUnretainedValue() as? UIApplication
    }

    static func sharedThrowing() throws -> UIApplication {
        guard let shared = self.shared else {
            throw Errors.noApplicationAvailable
        }

        return shared
    }
}

public extension AppExtensionSafeApplication {
    enum Errors: Error {
        case noApplicationAvailable
    }
}
#endif
