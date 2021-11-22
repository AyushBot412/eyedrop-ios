//
//  SizeManager.swift
//  Eyedrop Recognition
//
//  Created by Ludovico Veniani on 6/18/21.
//

import Foundation
import UIKit

class SizeManager {
    static var deviceHeight: CGFloat!
    static var deviceWidth: CGFloat!
    static var padding: CGFloat!
    
    static func numberOfLines(text: String, font: UIFont, width: CGFloat, lineHeight: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height / lineHeight
    }

    static func heightForView(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height
    }

    static func widthForView(text: String, font: UIFont, height: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: height))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.width
    }

    static func getMaximumFontInWidth(text: String, width: CGFloat, font: String) -> (maxFont: UIFont, maxHeight: CGFloat) {
        //        print("Target Width: \(width)")
        var lastDifference = CGFloat(0)
        var lastHeight = CGFloat(0)
        var lastFont = UIFont()
        var firstLoop = true
        for x in 1 ... 150 {
            let font = UIFont(name: font, size: CGFloat(x))!
            let height = heightForView(text: text, font: font, width: width)
            lastDifference = height - lastHeight
            if lastDifference > 5, !firstLoop {
                break
            }
            lastHeight = height
            lastFont = font
            firstLoop = false
        }
        //        print(lastDifference)
        //        print(lastFont)
        return (maxFont: lastFont, maxHeight: lastHeight)
    }

    static func getMaximumFontInHeight(text: String, height: CGFloat, font: String) -> (maxFont: UIFont, maxWidth: CGFloat) {
        var lastWidth = CGFloat(0)
        var lastHeight = CGFloat(0)
        var lastFont = UIFont()
        //        print("TARGET Height: \(height)")
        for x in 1 ... 150 {
            let font = UIFont(name: font, size: CGFloat(x))!
            let width = widthForView(text: text, font: font, height: height)
            let currHeight = heightForView(text: text, font: font, width: width)
            if currHeight > height {
                break
            }
            lastWidth = width
            lastFont = font
            lastHeight = currHeight
            print(lastFont)
            print(lastHeight)
        }
        //        print(lastFont)
        //        print(lastWidth)
        //        print(lastHeight    )
        return (maxFont: lastFont, maxWidth: lastWidth)
    }

    static func getMaximumFont(text: String, width: CGFloat, height: CGFloat, font: String) -> (maxFont: UIFont, maxWidth: CGFloat, maxHeight: CGFloat) {
        var lastWidth = CGFloat(0)
        var lastHeight = CGFloat(0)
        var lastFont = UIFont()
        //        print("TARGET Width: \(width)")

        var lastDifference = CGFloat(0)
        var firstLoop = true

        //        print("TARGET Height: \(height)")
        for x in 1 ... 150 {
            let font = UIFont(name: font, size: CGFloat(x))!
            let currWidth = widthForView(text: text, font: font, height: height)
            let currHeight = heightForView(text: text, font: font, width: width)
            lastDifference = currHeight - lastHeight
            if currHeight > height {
                break
            }
            if lastDifference > 5, !firstLoop {
                break
            }
            if currWidth > width {
                break
            }

            lastWidth = currWidth
            lastFont = font
            lastHeight = currHeight

            firstLoop = false

            //            print(lastFont)
            //            print(lastHeight)
            //            print(lastWidth)
            //            print(lastDifference)
        }
        //        print(lastFont)
        //        print(lastWidth)
        //        print(lastHeight    )
        return (maxFont: lastFont, maxWidth: lastWidth, maxHeight: lastHeight)
    }

}
