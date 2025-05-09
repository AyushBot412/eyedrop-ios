//
//  QRCodeMask.swift
//  Eyedrop Recognition
//
//  Created by Elise Jang on 3/20/25.
//

import UIKit

class QRCodeMask: UIView {
    public var cornerLength: CGFloat = 30
    public var lineWidth: CGFloat = 6
    public var lineColor: UIColor = .white
    public var maskSize: CGSize = CGSize(width: 200, height: 200)
    
    private var maskContainer: CGRect {
        CGRect(
            x: (bounds.width - maskSize.width) / 2,
            y: (bounds.height - maskSize.height) / 2,
            width: maskSize.width,
            height: maskSize.height
        )
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // Background mask
        context.setFillColor(UIColor.black.withAlphaComponent(0.5).cgColor)
        context.fill(bounds)
        
        let path = UIBezierPath(rect: maskContainer)
        context.setBlendMode(.clear)
        path.fill()
        context.setBlendMode(.normal)
        
        // Corner lines
        context.setStrokeColor(lineColor.cgColor)
        context.setLineWidth(lineWidth)
        
        drawCornerLines(in: context)
    }
    
    private func drawCornerLines(in context: CGContext) {
        let minX = maskContainer.minX, minY = maskContainer.minY
        let maxX = maskContainer.maxX, maxY = maskContainer.maxY
        
        context.setLineCap(.round)
        
        // Top-left corner
        context.move(to: CGPoint(x: minX, y: minY + cornerLength))
        context.addLine(to: CGPoint(x: minX, y: minY))
        context.addLine(to: CGPoint(x: minX + cornerLength, y: minY))
        
        // Top-right corner
        context.move(to: CGPoint(x: maxX - cornerLength, y: minY))
        context.addLine(to: CGPoint(x: maxX, y: minY))
        context.addLine(to: CGPoint(x: maxX, y: minY + cornerLength))
        
        // Bottom-right corner
        context.move(to: CGPoint(x: maxX, y: maxY - cornerLength))
        context.addLine(to: CGPoint(x: maxX, y: maxY))
        context.addLine(to: CGPoint(x: maxX - cornerLength, y: maxY))
        
        // Bottom-left corner
        context.move(to: CGPoint(x: minX + cornerLength, y: maxY))
        context.addLine(to: CGPoint(x: minX, y: maxY))
        context.addLine(to: CGPoint(x: minX, y: maxY - cornerLength))
        
        context.strokePath()
    }
}
