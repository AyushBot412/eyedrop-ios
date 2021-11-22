//
//  Constants.swift
//  Eyedrop Recognition
//
//  Created by Ludovico Veniani on 6/18/21.
//

import Foundation
import UIKit

enum BottleTypes_All: String, CaseIterable {
    case ALPHAGAN
    case COMBIGAN
    case DORZOLAMIDE_BLUE
    case DORZOLAMIDE_ORANGE
    case LATANOPROST
    case PREDFORTE
    case PREDFORTE_OFF_BRAND
    case RHOPRESSA
    case ROCKLATAN
    case VIGAMOX
    case VIGAMOX_OFF_BRAND
    
    func isEqual(to type: BottleType) -> Bool {
        switch self {
        case .ALPHAGAN:
            return type == .ALPHAGAN
        case .COMBIGAN:
            return type == .COMBIGAN
        case .DORZOLAMIDE_BLUE, .DORZOLAMIDE_ORANGE:
            return type == .DORZOLAMIDE
        case .LATANOPROST:
            return type == .LATANOPROST
        case .PREDFORTE, .PREDFORTE_OFF_BRAND:
            return type == .PREDFORTE
        case .RHOPRESSA:
            return type == .RHOPRESSA
        case .ROCKLATAN:
            return type == .ROCKLATAN
        case .VIGAMOX, .VIGAMOX_OFF_BRAND:
            return type == .VIGAMOX

        }
    }
}

enum BottleType: String, CaseIterable {
    case ALPHAGAN
    case COMBIGAN
    case DORZOLAMIDE
    case LATANOPROST
    case PREDFORTE
    case RHOPRESSA
    case ROCKLATAN
    case VIGAMOX
    
    static func createMap() -> [BottleType: Int] {
        var map = [BottleType: Int]()
        for type in Self.allCases {
            map[type] = 0
        }
        return map
    }
    

}

class Constants {    
    static func initialize(frame: CGRect) {
        SizeManager.deviceHeight = frame.height
        SizeManager.deviceWidth = frame.width
        SizeManager.padding = frame.width/30
        
        BottleDictionary.initialize()
    }
}
