//
//  UIView+ReusableIdentifier.swift
//  swapi
//
//  Created by Nicolas Desormiere on 8/9/19.
//  Copyright © 2019 Nicolas Desormiere. All rights reserved.
//

import Foundation
import UIKit

protocol ReuseIdentifier {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifier {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReuseIdentifier {}
extension UITableViewCell: ReuseIdentifier {}
extension UITableViewHeaderFooterView: ReuseIdentifier {}
