//
//  CoreDelegates.swift
//  Eyedrop Recognition
//
//  Created by Ludovico Veniani on 6/18/21.
//

import Foundation
import UIKit

protocol ImageDependancyDelegate: AnyObject {
    func updateImage(image: UIImage)
}

protocol ClassificationDelegate: AnyObject {
    func classifiedFrame(bottleType: BottleType?, bottleType_all: BottleTypes_All?)
}
