//
//  TextRecognitionManager.swift
//  Eyedrop Recognition
//
//  Created by Ludovico Veniani on 6/18/21.
//

import Foundation
import UIKit
import MLKitTextRecognition
import MLKit

class TextRecognitionManager {
    static func extractWords(from image: UIImage, completion: @escaping (Result<[String], Error>) -> Void) {
        let visionImage = VisionImage(image: image)
        visionImage.orientation = image.imageOrientation
        
        let textRecognizer = TextRecognizer.textRecognizer()
        
        textRecognizer.process(visionImage) { result, error in
            guard error == nil, let result = result else {
                // Error handling
                print("DEBUG: \(error)")
                DispatchQueue.main.async {
                completion(.failure(error!))
                }
                return
            }
            
            // Recognized text
            var words = [String]()
            
            for block in result.blocks {
                for line in block.lines {
                    for element in line.elements {
                        words.append(element.text)
                    }
                }
            }
            
            DispatchQueue.main.async {
                completion(.success(words))
            }
            
            
            
        }
        
    }
    
    var iter: Int = 0 {
        didSet {
            print(iter)
            let imageCount = Int(Self.shared.fileCounts[Self.shared.index])
            if iter == imageCount {
                print("\n\n\n\(BottleTypes_All.allCases[Self.shared.index].rawValue) SUMMARY:\nimageCount: \(imageCount)\naccurateCount: \(Self.shared.accurateCount)\naccuracy: \(Self.shared.accurateCount/Double(imageCount))\nnoMatchCount: \(Self.shared.noMatchesCount)")
            }
        }
    }
    var noMatchesCount: Double = 0
    var accurateCount: Double = 0
    let fileCounts = [102, 92, 90,102, 100, 102, 101, 103, 94, 101, 101]
    lazy var totalImages = Double(fileCounts.sumAll())
    static let shared = TextRecognitionManager()
    var index: Int!
    let lock = NSLock()
    
    
    static func beginTest(bottleType: BottleTypes_All) {
        let index = BottleTypes_All.allCases.firstIndex(of: bottleType)!
        Self.shared.index = index
        TextRecognitionManager.test(bottleType: bottleType, fileNum: -1, index: index)

    }
    
    
    static func test(bottleType: BottleTypes_All, fileNum: Int, index: Int) {
        
        let fNum = fileNum + 1

        guard fNum < Self.shared.fileCounts[index] else {

            return
        }
        print(bottleType, fileNum, index)
        
        var image: UIImage? = UIImage(named: "\(fNum)_\(bottleType.rawValue).JPG")!
        
        
        TextRecognitionManager.extractWords(from: image!) { result in
           
            switch result {
            case .success(let words):

                if let exactMatch = LabelRecognitionManager.getRecognitionMap(words: words).max(by: { a, b in a.value.score < b.value.score }) {
                    if bottleType.isEqual(to: exactMatch.key)  {
                        Self.shared.accurateCount += 1.0
         
                        
                        print("accurate :)")
                    } else {
                        print(words, exactMatch)
                        print()
                    }

                    image = nil
                    Self.shared.iter += 1
                    Self.test(bottleType: bottleType, fileNum: fileNum+1, index: index)
                } else if let fuzzyMatch = LabelRecognitionManager.getFuzzyRecognitionMap(words: words).max(by: { a, b in a.value.score < b.value.score }) {
                
                    
                    if bottleType.isEqual(to: fuzzyMatch.key)  {
                        Self.shared.accurateCount += 1.0
             
                        
                        print("accurate :)")

                    } else {
                        print(words, fuzzyMatch)
                        let fuzzyMap = LabelRecognitionManager.getFuzzyRecognitionMap(words: words).max(by: { a, b in a.value.score < b.value.score })
                        
                        print(fuzzyMap)
                        print()
                    }

                    image = nil
                    Self.shared.iter += 1
                    Self.test(bottleType: bottleType, fileNum: fileNum+1, index: index)
                    
                } else {
                    Self.shared.noMatchesCount += 1.0
                    
                    print("no match :(")
                    print(words)

                    image = nil
                    Self.shared.iter += 1
                    Self.test(bottleType: bottleType, fileNum: fileNum+1, index: index)
                }
                
                
                
                
                
                
                
            default:
                Self.shared.iter += 1
                image = nil
                Self.test(bottleType: bottleType, fileNum: fileNum+1, index: index)
                break
                
                
            }
            
        }
        
    }
    
    
    static func buildDict2_0() {
        
    }
    
    
}
