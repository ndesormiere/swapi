//
//  UIView+LayoutShortcuts.swift
//  swapi
//
//  Created by Nicolas Desormiere on 8/9/19.
//  Copyright © 2019 Nicolas Desormiere. All rights reserved.
//

import UIKit

extension UIView {
    
    public func constraint(for attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        for constraint in constraints {
            if constraint.firstAttribute == attribute {
                return constraint
            }
        }
        return nil
    }
    
    @discardableResult
    public func addSubviews(_ subviews: UIView...) -> UIView {
        return addSubviews(subviews)
    }
    
    @objc
    @discardableResult
    public func addSubviews(_ subviews: [UIView]) -> UIView {
        subviews.forEach { (subview) in
            addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        return self
    }
    
    @discardableResult
    public func fillSuperview() -> UIView {
        guard let superview = superview else {
            assertionFailure("No superview found!")
            return self
        }
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor)
            ])
        return self
    }
    
    @discardableResult
    public func centerInSuperview() -> UIView {
        guard let superview = superview else {
            assertionFailure("No superview found!")
            return self
        }
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor)
            ])
        return self
    }
    
    @discardableResult
    public func centerYToSuperview() -> UIView {
        guard let superview = superview else {
            assertionFailure("No superview found!")
            return self
        }
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        return self
    }
    
    @discardableResult
    public func centerXToSuperview() -> UIView {
        guard let superview = superview else {
            assertionFailure("No superview found!")
            return self
        }
        centerXAnchor.constraint(equalTo: superview.centerXAnchor)
        return self
    }
}
