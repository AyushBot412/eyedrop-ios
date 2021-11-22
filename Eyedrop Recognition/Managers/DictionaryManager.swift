//
//  DictionaryManager.swift
//  Eyedrop Recognition
//
//  Created by Ludovico Veniani on 6/18/21.
//

import Foundation
class DictionaryManager {
    
    static func buildBottle(bottleType: BottleType, words: [String]) {
        var allWordsGrams = [String]()
        
        for word in words {
            if word.count >= 4 {
                //Create  ngrams
                for i in 3..<word.count {
                    let ngramFront = String(word.prefix(i))
                    allWordsGrams.append(ngramFront)
                    
                    let ngramBack = String(word.suffix(i))
                    allWordsGrams.append(ngramBack)
                }
                

            }
            allWordsGrams.append(word)
            

        }

        
        print(allWordsGrams)
        return
    }
    
    static func uniqueify() {
        //Used to create UniqueWords
        var kingMap = [String:Int]()
        
        for bottleSet in BottleDictionary.OriginalWords.array {
            for word in bottleSet {
                if kingMap[word] == nil {
                    kingMap[word] = 1
                } else {
                    kingMap[word]! += 1
                }
            }
        }
        
        for bottleSet in BottleDictionary.OriginalWords.array {
            var tmp = [String]()
            
            for word in bottleSet {
                if kingMap[word]! <= 1 {
                    tmp.append(word)
                }
            }
            print(tmp)
        }
        
    }
    
}
