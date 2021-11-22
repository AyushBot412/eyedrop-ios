//
//  LabelRecognitionManager.swift
//  Eyedrop Recognition
//
//  Created by Ludovico Veniani on 8/8/21.
//

import Foundation
import Fuse

private let goldenInc = 10
class LabelRecognitionManager {
    static let fuse = Fuse(location: 0, distance: 32, threshold: 0.4, maxPatternLength: 32, isCaseSensitive: true, tokenize: false)
    
    
    static func getRecognitionMap(words: [String]) -> [BottleType:(matches: [String], score: Int)] {
        var map = [BottleType:(matches: [String], score: Int)]()
        
        for word in words {
            for (bottleType, set) in BottleDictionary.strictBottleTypeMap {
                if set.contains(word) {
                    let inc = BottleDictionary.goldenBottyleTypeMap[bottleType]!.contains(word) ? goldenInc : 1
                    if let item = map[bottleType] {
                        map[bottleType]! = (matches: item.matches + [word], score: item.score + inc)
                    } else  {
                        map[bottleType] = (matches: [word], score: inc)
                    }
                }
            }
        }
        
        return map
    }
    
    static func getFuzzyRecognitionMap(words: [String]) -> [BottleType:(matches: [String], score: Int)] {
        var map = [BottleType:(matches: [String], score: Int)]()
        
        
                
        for word in words {
            guard word.count > 3 else { continue }
            
            var threshold = 0.26 //0.08
            if String(word.prefix(2)).isInt ||  String(word.suffix(2)).isInt {
                threshold = 0.2
            } else if word.count < 5 {
                threshold = 0.15
            }
       
            

            // Improve performance by creating the pattern once
            let pattern = Self.fuse.createPattern(from: word)

            for (bottleType, set) in BottleDictionary.goldenBottyleTypeMap {
                var fuzzyMatches = [String]()
                for item in set {
                    if let diff = Self.fuse.search(pattern, in: item)?.score, diff < threshold {
                        fuzzyMatches.append(item)
                    }
                }
                
                if !fuzzyMatches.isEmpty {
                    var inc = 1
                    
                    for fuzzyMatch in fuzzyMatches {
                        if BottleDictionary.goldenBottyleTypeMap[bottleType]!.contains(fuzzyMatch) {
                            inc = goldenInc
                            break
                        }
                    }
                
                    
                   
                    if let mapObj = map[bottleType] {
                        map[bottleType] = (matches: mapObj.matches + [word], score: mapObj.score + inc)
                    } else {
                        map[bottleType] = (matches: [word], score: inc)
                    }
                }
                
            }
            

        }
        
        return map
    }
}
