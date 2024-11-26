//
//  MarkupView.swift
//  Racing2D
//
//  Created by Даниил on 26.11.24.
//

import UIKit

private extension CGFloat {
    static let numberOfMarkups: CGFloat = 24
}

class MarkupView: UIView {
    
    override func draw(_ rect: CGRect) {
        // Создаем путь для линии
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.width / 2, y: .zero)) // Начальная точка
        path.addLine(to: CGPoint(x: rect.width / 2, y: rect.height)) // Конечная точка
        
        // Настройка цвета и ширины линии
        UIColor.white.setStroke() // Цвет линии
        path.lineWidth = 6 // Ширина линии
        
        // Устанавливаем стиль пунктирной линии
        let dashPattern: [CGFloat] = [rect.height / .numberOfMarkups, rect.height / (.numberOfMarkups * 2)] // Длина штриха и пробела
        path.setLineDash(dashPattern, count: dashPattern.count, phase: .zero)
        
        // Рисуем линию
        path.stroke()
    }
}
