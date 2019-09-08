//
//  UIStackView.swift
//  swapi
//
//  Created by Nicolas Desormiere on 9/9/19.
//  Copyright © 2019 Nicolas Desormiere. All rights reserved.
//

import UIKit

extension UIStackView {
    
    public func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { (subview) in
            addArrangedSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
}
