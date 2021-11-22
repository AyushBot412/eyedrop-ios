//
//  BottleDictionaries.swift
//  Eyedrop Recognition
//
//  Created by Ludovico Veniani on 6/18/21.
//

import Foundation
class BottleDictionary {
    static var bottleTypeMap: [BottleType:Set<String>]!
    static var strictBottleTypeMap: [BottleType:Set<String>]!
    static var goldenBottyleTypeMap: [BottleType:Set<String>]!
    
    
    static func initialize() {
        Self.bottleTypeMap = [.ALPHAGAN: Self.UniqueWords.ALPHAGAN, .DORZOLAMIDE: Self.UniqueWords.DORZOLAMIDE, .PREDFORTE:Self.UniqueWords.PREDFORTE,  .VIGAMOX: Self.UniqueWords.VIGAMOX, .LATANOPROST: Self.UniqueWords.LATANOPROST, .COMBIGAN: Self.UniqueWords.COMBIGAN,  .RHOPRESSA: Self.UniqueWords.RHOPRESSA,  .ROCKLATAN: Self.UniqueWords.ROCKLATAN]

        
        Self.strictBottleTypeMap = [.ALPHAGAN: Self.StrictUniqueWords.ALPHAGAN, .DORZOLAMIDE: Self.StrictUniqueWords.DORZOLAMIDE, .PREDFORTE:Self.StrictUniqueWords.PREDFORTE,  .VIGAMOX: Self.StrictUniqueWords.VIGAMOX, .LATANOPROST: Self.StrictUniqueWords.LATANOPROST, .COMBIGAN: Self.StrictUniqueWords.COMBIGAN,  .RHOPRESSA: Self.StrictUniqueWords.RHOPRESSA,  .ROCKLATAN: Self.StrictUniqueWords.ROCKLATAN]
        
        Self.goldenBottyleTypeMap = [.ALPHAGAN: Self.StrictUniqueWords.goldenALPHAGAN, .DORZOLAMIDE: Self.StrictUniqueWords.goldenDORZOLAMIDE, .PREDFORTE:Self.StrictUniqueWords.goldenPREDFORTE,  .VIGAMOX: Self.StrictUniqueWords.goldenVIGAMOX, .LATANOPROST: Self.StrictUniqueWords.goldenLATANOPROST, .COMBIGAN: Self.StrictUniqueWords.goldenCOMBIGAN,  .RHOPRESSA: Self.StrictUniqueWords.goldenRHOPRESA,  .ROCKLATAN: Self.StrictUniqueWords.goldenROCKLATAN]
        

    }
    
    static func getSimilarityRating(query words: [String]) -> Int {
        return 0
    }
    
    struct StrictUniqueWords {
        
        static let goldenALPHAGAN = Set(["AlphagarP", "Alphagan", "AlphaganP", "Alphagar", "0023-9321-10", "0023-9321", "9321-10", "0023-9321-05", "0023-9321", "9321-05"])
        static let ALPHAGAN = Set(["capacity", "AlphagarP",  "0.1%", "times", "daily", "Alphagan",  "three", "AlphaganP"])
        
        static let goldenDORZOLAMIDE = Set(["60429-115-10", "60429-115", "115-10", "60429-115-05", "60429-115", "115-05", "24208-485-10", "24208-485", "485-10",   "HCI", "HCI-", "(LOMB", "Lomb", "(Dorzolamide", "Dorzolamide.", "Dorzolamide.", "Dorzolamide", "Bausch", "BAUSCH"])
        static let DORZOLAMIDE = Set(["33637",  "+", "2%", "APPLICATION",  "HCI-", "+LOMB", "mg/mL)", "Contains:", "Lomb", "Equivalent", "GSMS", "Tampa,", "9355700",   "BAUSCH+LOMB", "22.3", "LOMB",  "(Dorzolamide",  "equivalent", "FL", "Timolol", "HCI", "*Each", "AB48509",  "Dorzolamide.", "Dorzolamide", "Bausch", "Hydrochloride", "BAUSCH", "60429-115-10", "60429-115", "115-10", "60429-115-05", "60429-115", "115-05", "24208-485-10", "24208-485", "485-10", ])
        
        static let goldenPREDFORTE = Set(["FORTE", "PREDNISOLONE", "prednisolone",  "PACIFIC", "PHARMA.", "PRED", "acetate", "ACETATE", "(microfine", "60758-119-15", "60758-119", "119-15", "11980-180-05", "11980-180", "180-05", "11980-180-10", "11980-180", "180-10"])
        static let PREDFORTE = Set(["freezing", "All", "FORTE", "Shake",  "position.", "suspension)", "well", "2020", "tempertures", "PREDNISOLONE", "acetate", "using.", "PRED",  "PHARMA.", "reserved", "up", "suspension,", "freezing.", "(prednisolone", "1%", "ACETATE", "suspension", "07940", "prednisolone", "before", "PACIFIC",  "(microfine", "Madison,", "upright",  "temperatures", "rights", "60758-119-15", "60758-119", "119-15", "11980-180-05", "11980-180", "180-05", "11980-180-10", "11980-180", "180-10"])
        
        static let goldenVIGAMOX = Set(["VIGAMOX°", "Novartis", "VIGAMOX", "Moxifloxacin", "moxifloxacin", "0065-4013-03", "0781-7135-93", "0065-4013", "4013-03", "0781-7135", "7135-93",])
        static let VIGAMOX = Set(["Moxifloxacin", "moxifloxacin", "5.45mg", "2016", "enclosed", "hydochioride", "Bayer", "TX", "Read", "VIGAMOX°",  "Each", "2-25", "Novartis", "OPHTHALMIC", "2°-25°C",  "5.45", "OPTHALMIC", "0065-4013-03", "0065-4013", "4013-03", "0781-7135-93", "0781-7135", "7135-93", "base", "contains:", "Licensed", "AG", "VIGAMOX", ])
        
        static let goldenLATANOPROST = Set([ "61314-547-01", "61314-547", "547-01" ])
        static let LATANOPROST = Set(["09/2016", "61314-547-01", "61314-547", "547-01", "Rev.", "Texas", "125", "evening.", "ug/2.5"])
        
        static let goldenCOMBIGAN = Set(["Combigan", "0023-9211-05", "0023-9211", "9211-05", ])
        static let COMBIGAN = Set(["0.2%/0.5%", "Actives:", "0.2%/timolol", "(0.005%)", "Combigan", "0023-9211-05", "0023-9211", "9211-05",])
        
        static let goldenRHOPRESA = Set(["rhopressa", "70727-497-99", "70727-497"," 497-99" ])
        static let RHOPRESSA = Set(["70727-497-99", "70727-497"," 497-99", "0.02%", "rhopressa"])
        
        static let goldenROCKLATAN = Set(["rocklatan", "70727-529-99", "70727-529", "529-99",])
        static let ROCKLATAN = Set(["rocklatan", "70727-529-99", "70727-529", "529-99", "0.02%/0.005%"])
    }
    
    struct UniqueWords {
        
        
        static let ALPHAGAN = Set(["capacity", "AlphagarP", "0023-9321-10", "One", "0.1%", "times", "daily", "Alphagan", "0023-9321-05", "three", "eye(s).", "AlphaganP"])
        
        static let DORZOLAMIDE = Set(["33637", "60429-115-10", "+", "2%", "APPLICATION", "|", "HCI-", "+LOMB", "mg/mL)", "Contains:", "Lomb", "Equivalent", "GSMS", "Tampa,", "9355700", "10", "Solution,", "24208-485-05", "BAUSCH+LOMB", "22.3", "LOMB", "EYE", "mg", "Incorporated", "(Dorzolamide", "equivalent", "24208-485-10", "FL", "Timolol", "HCI", "*Each", "AB48509", "60429-115-05", "Dorzolamide.", "Dorzolamide", "Bausch", "Hydrochloride", "BAUSCH"])
        
        static let PREDFORTE = Set(["freezing", "All", "an", "FORTE", "Shake", "11980-180-10", "60758-119-15", "position.", "suspension)", "well", "2020", "tempertures", "PREDNISOLONE", "acetate", "using.", "PRED", "25°C", "PHARMA.", "reserved", "up", "suspension,", "freezing.", "(prednisolone", "1%", "ACETATE", "suspension", "07940", "prednisolone", "before", "PACIFIC", "11980-180-05", "(microfine", "Madison,", "upright", "2014", "temperatures", "Allergan.", "rights", "15"])
        
        static let VIGAMOX = Set(["Moxifloxacin", "moxifloxacin", "5.45mg", "2003,", "2016", "enclosed", "hydochioride", "Bayer", "TX",  "Read", "VIGAMOX°", "mg.", "Each", "2-25", "Novartis", "OPHTHALMIC", "2°-25°C", "as", "5.45", "OPTHALMIC", "0065-4013-03", "0781-7135-93", "base", "contains:", "Licensed", "AG", "3", "O8540", "VIGAMOX", "Inc,", "ONLY."])
        
        static let LATANOPROST = Set(["1", "09/2016", "eye(s)", "Latanoprost", "EYES", "61314-547-01", "Rev.", "Texas", "125", "evening.", "ug/2.5"])
        
        static let COMBIGAN = Set(["0.2%/0.5%", "Actives:", "0.2%/timolol", "(0.005%)",  "Combigan",  "0023-9211-05"])
        
        static let RHOPRESSA = Set(["70727-497-99","0.02%", "rhopressa"])
        
        static let ROCKLATAN = Set(["rocklatan", "and", "opthalmic", "latanoprost", "70727-529-99", "0.02%/0.005%"])
    }
    
    struct OriginalWords {
        static let array = [Self.ALPHAGAN, Self.DORZOLAMIDE, Self.PREDFORTE, Self.VIGAMOX, Self.LATANOPROST, Self.COMBIGAN, Self.RHOPRESSA, Self.ROCKLATAN]
        
        static let ALPHAGAN = Set(["ALLERGAN", "NDC", "0023-9321-05", "0023-9321-10", "Rx", "only", "Alphagan", "AlphaganP", "AlphagarP", "(brimonidine", "tartrate", "ophthalmic", "solution)", "0.1%", "5", "mL", "sterile", "USUAL", "DOSAGE:", "One", "drop", "three", "times", "daily", "to", "affected", "eye(s).", "Storage:", "Store", "at", "15°-25°C", "(59°-77°F).", "Note:", "Bottle", "filled", "to", "1/2", "capacity", "©", "2013", "Allergan,", "Inc.", "Irvine,", "CA", "92612,", "U.S.A."])
        
        static let DORZOLAMIDE = Set(["NDC",  "60429-115-05", "60429-115-10", "GSMS", "|", "Dorzolamide", "HCI-", "Timolol", "Maleate", "Ophthalmic", "Solution", "10", "mL", "Rx", "only", "NDC", "24208-485-05", "24208-485-10", "BAUSCH+LOMB", "BAUSCH", "+LOMB", "BAUSCH", "+", "LOMB", "Dorzolamide", "HCI", "Ophthalmic", "Solution,", "2%", "(Sterile)", "Dorzolamide", "Equivalent", "(Dorzolamide", "hydrochloride", "USP", "22.3", "mg/mL)", "10", "mL", "Rx", "only", "Usual", "Dosage:", "See", "package", "insert.", "Protect", "from", "light.", "Bausch", "Lomb", "Incorporated", "Tampa,", "FL", "33637", "9355700", "AB48509", "FOR", "TOPICAL", "APPLICATION", "IN", "THE", "EYE", "*Each", "mL", "Contains:", "Active:", "Dorzolamide", "Hydrochloride", "USP", "22.3", "mg", "equivalent", "to", "20", "mg", "Dorzolamide."])
        
        static let PREDFORTE = Set(["ALLERGAN", "NDC", "11980-180-05", "11980-180-10", "PRED", "FORTE", "(prednisolone", "acetate", "ophthalmic", "suspension,", "USP", "1%", "5", "mL", "Rx", "only", "sterile", "CONTAINS:", "Active:", "prednisolone", "acetate", "(microfine", "suspension)", "1%", "Preservative:", "benzalkonium", "chloride", "USUAL", "DOSAGE:", "Refer", "to", "package", "insert.", "Storage:", "Store", "at", "temperatures", "up", "to", "25°C", "(77°F).", "Protect", "from", "freezing.", "Store", "in", "an", "upright", "position.", "Shake", "well", "before", "using.", "Note:", "Bottle", "filled", "to", "1/2", "capacity.", "©", "2014", "Allergan,", "Inc.,", "Irvine,", "CA", "92612,", "U.S.A.", "PACIFIC", "PHARMA.", "NDC", "60758-119-15", "Rx", "Only", "PREDNISOLONE", "ACETATE", "ophthalmic", "suspension,", "USP", "1%", "15", "mL", "Sterile", "CONTAINS:", "Active:", "prednisolone", "acetate", "(microfine", "suspension" ,"1%", "Preservative:", "benzalkonium", "chloride", "USUAL", "DOSAGE:", "Shake", "well", "before", "using.", "Refer", "to", "package", "insert.", "Sorage:", "Store", "at", "tempertures", "up", "to", "25°C", "(77°F).", "Protect", "from", "freezing", "Store", "in", "an", "upright", "position.", "2020", "Allergan.", "All", "rights", "reserved", "Madison,", "NJ", "07940"])
        
        static let VIGAMOX = Set(["NDC", "0065-4013-03", "VIGAMOX","VIGAMOX°", "moxifloxacin", "hydrochloride", "ophthalmic", "solution)", "0.5%", "as", "base", "3", "mL", "STERILE", "FOR", "TOPICAL", "OPTHALMIC", "USE", "ONLY", "Each", "mL", "contains:", "moxifloxacin", "hydrochloride", "5.45mg", "Storage:", "Store", "at",  "2°-25°C" ,"2-25", "(36°-77°F).", "Usual", "Dosage:", "Read", "enclosed", "insert", "2003,", "2016", "Novartis", "Rx", "Only", "NDC", "0781-7135-93", "Moxifloxacin", "Ophthalmic", "Solution", "0.5%", "FOR", "TOPICAL", "OPHTHALMIC", "USE", "ONLY.", "STERILE", "Rx", "Only", "SANDOZ", "3", "mL", "Each", "mL", "contains:", "moxifloxacin", "hydochioride", "5.45", "mg.", "Storage:", "Store", "at", "2°-25°C", "(36°-77°F).", "Usual", "Dosage:", "Read", "enclosed", "insert", "Manutactured", "by", "Alcon", "Laboratories,", "Fort", "Worth,", "TX", "76134", "for", "Sandoz", "Inc,", "Princeton,", "NJ", "O8540", "Licensed", "from", "Bayer", "AG"])
        
        static let LATANOPROST = Set(["NDC", "61314-547-01", "Latanoprost", "Ophthalmic", "Solution", "STERILE", "125", "ug/2.5", "mL", "SANDOZ", "USUAL", "DOSAGE:", "1", "drop", "in", "the", "affected", "eye(s)", "in", "the", "evening.", "FOR", "USE", "IN", "THE", "EYES", "ONLY", "Rev.", "09/2016", "only", "Manufactured", "by", "Alcon", "Laboratories,", "Inc.", "Fort", "Worth,", "Texas", "76134", "for", "Sandoz", "Inc.", "Princeton,", "NJ"])
        
        static let COMBIGAN = Set(["ALLERGAN", "NDC", "0023-9211-05", "Rx", "only", "Combigan", "brimonidine", "tartrate/timolol", "maleate", "ophthalmic", "solution)", "0.2%/0.5%", "sterile", "5", "mL", "CONTAINS:", "Actives:", "brimonidine", "tartrate", "0.2%/timolol", "0.5%", "Preservative:", "benzalkonium", "chloride", "(0.005%)", "USUAL", "DOSAGE:", "Refer", "to", "package", "insert", "Storage:", "Store", "at", "15°-25°C", "(59°-77°F)",  "15°-25°C (59°-77°F)", "Protect", "from", "light.", "Note:", "Bottle", "filled", "to","1/2", "capacity.", "©", "2013", "Allergan,", "Inc.,", "Irvine,", "CA", "92612,", "U.S.A."])
        
        static let RHOPRESSA = Set(["NDC", "70727-497-99", "rhopressa", "(netorsudil", "ophthalmic", "solution)", "0.02%", "Sterile", "2.5", "mL", "Rx", "only", "For", "topical", "application", "in", "the", "eye.", "See", "carton", "for", "storage", "conditions.", "Manufactured", "for.", "Aerie", "Pharmaceuticals,", "Inc.", "Irvine,", "CA", "92614"])
        
        static let ROCKLATAN = Set(["NDC", "70727-529-99", "rocklatan", "(netarsudil", "and", "latanoprost", "opthalmic", "solution)", "0.02%/0.005%", "Sterile", "2.5", "ml", "Rx", "only", "For", "topical", "application", "in", "the", "eye.", "See", "carton", "for", "storage", "conditions.", "Manufactured", "for.", "Aerie", "Pharmaceuticals,", "Inc.", "Irvine,", "CA", "92614"])

    }
    
}



/*
 struct OriginalWords {
     static let array = [Self.ALPHAGAN, Self.DORZOLAMIDE_BLUE, Self.DORZOLAMIDE_ORANGE, Self.PREDFORTE, Self.PREDFORTE_OFF_BRAND, Self.VIGAMOX, Self.VIGAMOX_OFF_BRAND, Self.LATANOPROST]
     
     static let ALPHAGAN = Set(["ALLERGAN", "NDC", "0023-9321-05", "0023-9321-10", "Rx", "only", "Alphagan", "AlphaganP", "AlphagarP", "(brimonidine", "tartrate", "ophthalmic", "solution)", "0.1%", "5", "mL", "sterile", "USUAL", "DOSAGE:", "One", "drop", "three", "times", "daily", "to", "affected", "eye(s).", "Storage:", "Store", "at", "15°-25°C", "(59°-77°F).", "Note:", "Bottle", "filled", "to", "1/2", "capacity", "©", "2013", "Allergan,", "Inc.", "Irvine,", "CA", "92612,", "U.S.A."])
     
     static let DORZOLAMIDE_BLUE = Set(["NDC",  "60429-115-05", "60429-115-10", "GSMS", "|", "Dorzolamide", "HCI-", "Timolol", "Maleate", "Ophthalmic", "Solution", "10", "mL", "Rx", "only"])
     
     static let DORZOLAMIDE_ORANGE = Set(["NDC", "24208-485-05", "24208-485-10", "BAUSCH+LOMB", "BAUSCH", "+LOMB", "BAUSCH", "+", "LOMB", "Dorzolamide", "HCI", "Ophthalmic", "Solution,", "2%", "(Sterile)", "Dorzolamide", "Equivalent", "(Dorzolamide", "hydrochloride", "USP", "22.3", "mg/mL)", "10", "mL", "Rx", "only", "Usual", "Dosage:", "See", "package", "insert.", "Protect", "from", "light.", "Bausch", "&", "Lomb", "Incorporated", "Tampa,", "FL", "33637", "9355700", "AB48509", "FOR", "TOPICAL", "APPLICATION", "IN", "THE", "EYE", "*Each", "mL", "Contains:", "Active:", "Dorzolamide", "Hydrochloride", "USP", "22.3", "mg", "equivalent", "to", "20", "mg", "Dorzolamide."])
     
     static let PREDFORTE = Set(["ALLERGAN", "NDC", "11980-180-05", "11980-180-10", "PRED", "FORTE", "(prednisolone", "acetate", "ophthalmic", "suspension,", "USP", "1%", "5", "mL", "Rx", "only", "sterile", "CONTAINS:", "Active:", "prednisolone", "acetate", "(microfine", "suspension)", "1%", "Preservative:", "benzalkonium", "chloride", "USUAL", "DOSAGE:", "Refer", "to", "package", "insert.", "Storage:", "Store", "at", "temperatures", "up", "to", "25°C", "(77°F).", "Protect", "from", "freezing.", "Store", "in", "an", "upright", "position.", "Shake", "well", "before", "using.", "Note:", "Bottle", "filled", "to", "1/2", "capacity.", "©", "2014", "Allergan,", "Inc.,", "Irvine,", "CA", "92612,", "U.S.A."])
     
     static let PREDFORTE_OFF_BRAND = Set(["PACIFIC", "PHARMA.", "NDC", "60758-119-15", "Rx", "Only", "PREDNISOLONE", "ACETATE", "ophthalmic", "suspension,", "USP", "1%", "15", "mL", "Sterile", "CONTAINS:", "Active:", "prednisolone", "acetate", "(microfine", "suspension" ,"1%", "Preservative:", "benzalkonium", "chloride", "USUAL", "DOSAGE:", "Shake", "well", "before", "using.", "Refer", "to", "package", "insert.", "Sorage:", "Store", "at", "tempertures", "up", "to", "25°C", "(77°F).", "Protect", "from", "freezing", "Store", "in", "an", "upright", "position.", "2020", "Allergan.", "All", "rights", "reserved", "Madison,", "NJ", "07940"])
     
     static let VIGAMOX = Set(["NDC", "0065-4013-03", "VIGAMOX","VIGAMOX°", "moxifloxacin", "hydrochloride", "ophthalmic", "solution)", "0.5%", "as", "base", "3", "mL", "STERILE", "FOR", "TOPICAL", "OPTHALMIC", "USE", "ONLY", "Each", "mL", "contains:", "moxifloxacin", "hydrochloride", "5.45mg", "Storage:", "Store", "at",  "2°-25°C" ,"2-25", "(36°-77°F).", "Usual", "Dosage:", "Read", "enclosed", "insert", "2003,", "2016", "Novartis", "Rx", "Only"])
     
     static let VIGAMOX_OFF_BRAND = Set(["NDC", "0781-7135-93", "Moxifloxacin", "Ophthalmic", "Solution", "0.5%", "FOR", "TOPICAL", "OPHTHALMIC", "USE", "ONLY.", "STERILE", "Rx", "Only", "SANDOZ", "3", "mL", "Each", "mL", "contains:", "moxifloxacin", "hydochioride", "5.45", "mg.", "Storage:", "Store", "at", "2°-25°C", "(36°-77°F).", "Usual", "Dosage:", "Read", "enclosed", "insert", "Manutactured", "by", "Alcon", "Laboratories,", "Fort", "Worth,", "TX", "76134", "for", "Sandoz", "Inc,", "Princeton,", "NJ", "O8540", "Licensed", "from", "Bayer", "AG"])
     
     static let LATANOPROST = Set(["NDC", "61314-547-01", "Latanoprost", "Ophthalmic", "Solution", "STERILE", "125", "ug/2.5", "mL", "SANDOZ", "USUAL", "DOSAGE:", "1", "drop", "in", "the", "affected", "eye(s)", "in", "the", "evening.", "FOR", "USE", "IN", "THE", "EYES", "ONLY", "Rev.", "09/2016", "only", "Manufactured", "by", "Alcon", "Laboratories,", "Inc.", "Fort", "Worth,", "Texas", "76134", "for", "Sandoz", "Inc.", "Princeton,", "NJ", "08540"])
     
     static let COMBIGAN = Set(["ALLERGAN", "NDC", "0023-9211-05", "Rx", "only", "Combigan", "brimonidine", "tartrate/timolol", "maleate", "ophthalmic", "solution)", "0.2%/0.5%", "sterile", "5", "mL", "CONTAINS:", "Actives:", "brimonidine:", "tartrate", "0.2%/timolol", "0.5%", "Preservative:", "benzalkonium", "chloride", "(0.005%)", "USUAL", "DOSAGE:", "Refer", "to", "package", "insert", "Storage:", "Store", "at", "15°-25°C", "(59°-77°F)",  "15°-25°C (59°-77°F)", "Protect", "from", "light.", "Note:", "Bottle", "filled", "to","1/2", "capacity.", "©", "2013", "Allergan,", "Inc.,", "Irvine,", "CA", "92612,", "U.S.A."])
     
     static let RHOPRESSA = Set(["NDC", "70727-497-99", "rhopressa", "(netorsudil", "ophthalmic", "solution)", "0.02%", "Sterile", "2.5", "mL", "Rx", "only", "For", "topical", "application", "in", "the", "eye.", "See", "carton", "for", "storage", "conditions.", "Manufactured", "for.", "Aerie", "Pharmaceuticals,", "Inc.", "Irvine,", "CA", "92614"])
     
     static let ROCKLATAN = Set(["NDC", "70727-529-99", "rocklatan", "(netarsudil", "and", "latanoprost", "opthalmic", "solution)", "0.02%/0.005%", "Sterile", "2.5", "ml", "Rx", "only", "For", "topical", "application", "in", "the", "eye.", "See", "carton", "for", "storage", "conditions.", "Manufactured", "for.", "Aerie", "Pharmaceuticals,", "Inc.", "Irvine,", "CA", "92614"])
 }
 */
