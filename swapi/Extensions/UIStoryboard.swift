//
//  UIStoryboard.swift
//  swapi
//
//  Created by Nicolas Desormiere on 9/9/19.
//  Copyright © 2019 Nicolas Desormiere. All rights reserved.
//

import UIKit

extension UIStoryboard {
    enum Storyboards: String {
        case main = "Main"
        case launchScreen = "LaunchScreen"
        
        static func instanciate(_ storyboard: Storyboards) -> UIStoryboard {
            return UIStoryboard.init(name: storyboard.rawValue, bundle: nil)
        }
    }
}
