//
//  NSObject+NameOfClass.swift
//  swapi
//
//  Created by Nicolas Desormiere on 8/9/19.
//  Copyright © 2019 Nicolas Desormiere. All rights reserved.
//

import Foundation

extension NSObject {
    
    class var nameOfClass: String {
        var name = "Unknown Class"
        if let theName = NSStringFromClass(self).components(separatedBy: ".").last {
            name = theName
        }
        return name
    }
    
    var nameOfClass: String {
        return type(of: self).nameOfClass
    }
}
