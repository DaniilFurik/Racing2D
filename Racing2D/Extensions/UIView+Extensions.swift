//
//  UIView+Extensions.swift
//  Racing2D
//
//  Created by Даниил on 29.11.24.
//

import UIKit

private enum Constants {
    static let cornerRadius: CGFloat = 10
    static let offset: CGFloat = 10
    static let opacity: Float = 0.75
}

extension UIView {
    func dropShadow() {
        layer.masksToBounds = false // тень за границей экран
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = Constants.opacity
        layer.shadowRadius = Constants.cornerRadius
        layer.shadowOffset = CGSize(width: Constants.offset, height: Constants.offset)
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
       
        //layer.shouldRasterize = true  // делает тень более грубой (более натуральной), но кривит шрифты
    }
    
    func addGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.lightGray.cgColor, UIColor.systemGreen.cgColor, UIColor.lightGray.cgColor]
        gradient.locations = [0.2, 0.5, 0.8]
        gradient.startPoint = .zero
        gradient.endPoint = CGPoint.init(x: 1, y: 1)
        gradient.cornerRadius = layer.cornerRadius
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
    }
}
