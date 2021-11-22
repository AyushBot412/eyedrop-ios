//
//  Factory.swift
//  Eyedrop Recognition
//
//  Created by Ludovico Veniani on 6/18/21.
//

import Foundation
import UIKit

class Factory {
    static func createImageView() -> UIImageView {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        
        return view
        
    }
    
    static func createPaddinglabel() -> PaddingLabel {
        let view = PaddingLabel()
        view.insets(top: 0, bottom: 0, left: 0, right: 0)
        view.font = Fonts.primary
        view.numberOfLines = 0
        view.adjustsFontForContentSizeCategory = true
        view.translatesAutoresizingMaskIntoConstraints = false
     
        
        return view
        
    }
    
    static func createImageBarItem(VC: UIViewController, image: String, color: UIColor? = .black, f: Selector) -> UIBarButtonItem {
        let backArrow = UIButton(type: .system)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: Fonts.navigationTitle.pointSize, weight: .bold)
        backArrow.setImage(UIImage(systemName: image, withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate), for: .normal)
        print("$$$ conurrent: \(f)")

        backArrow.tintColor = color
        backArrow.addTarget(VC, action: f, for: .touchUpInside)

        let barButtonItem = UIBarButtonItem(customView: backArrow)
        backArrow.widthAnchor.constraint(equalToConstant: 30).isActive = true
        backArrow.heightAnchor.constraint(equalToConstant: 30).isActive = true

        return barButtonItem
    }

    static func createTextBarItem(VC: UIViewController, text: String, f: Selector, color: UIColor? = UIColor.systemBlue, alighnmentRight _: Bool? = true) -> UIBarButtonItem {
        // Done Btn
        let doneBtn = UIButton(type: .system)
        let font = Fonts.navigationTitle
        let attributedTitle = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color!])
        doneBtn.setAttributedTitle(attributedTitle, for: .normal)

        doneBtn.tintColor = color!
        doneBtn.addTarget(VC, action: f, for: .touchUpInside)

        let barButtonItem = UIBarButtonItem(customView: doneBtn)
        doneBtn.widthAnchor.constraint(equalToConstant: SizeManager.widthForView(text: text, font: font, height: 500)).isActive = true
        doneBtn.heightAnchor.constraint(equalToConstant: 80).isActive = true

        return barButtonItem
    }
}
