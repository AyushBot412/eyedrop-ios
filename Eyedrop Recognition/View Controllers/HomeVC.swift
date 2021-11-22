
//
//  ViewController.swift
//  Eyedrop Recognition
//
//  Created by Ludovico Veniani on 6/18/21.
//


import UIKit
import AVFoundation

class HomeVC: UIViewController {
    var i = 0
    var timer: Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
   
//        var block: () -> Void = {
//
//            TextRecognitionManager.test(bottleType: BottleTypes_All.allCases[self.i], fileNum: -1, index: self.i)
//                 self.i += 1
//
//                 if self.i > BottleTypes_All.allCases.count {
//                     self.timer.invalidate()
//                 }
//        }
//
//        block()
//        self.timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: { _ in
//            block()
//        })

        
        
//        TextRecognitionManager.beginTest(bottleType: .VIGAMOX_OFF_BRAND)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    
    }
    //MARK: Variables
    
    var currentBottleType: BottleType? {
        didSet {
            if oldValue != self.currentBottleType {
                //SPEAK
                guard let text = self.currentBottleType?.rawValue else { return }
                let utterance = AVSpeechUtterance(string: text)
                utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                utterance.rate = 0.3

                let synthesizer = AVSpeechSynthesizer()
                synthesizer.speak(utterance)
            }
        }
    }
    //MARK: Views
    lazy var captureVC: CaptureVC = {
        let VC = CaptureVC()
        VC.classificationDelegate = self
        VC.view.translatesAutoresizingMaskIntoConstraints = false
        return VC
    }()
    
    
    let imageView: UIImageView = {
        let view = Factory.createImageView()
        view.backgroundColor = .purple
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let primaryLbl: PaddingLabel = {
        let view = Factory.createPaddinglabel()
        view.textColor = .black
        view.textAlignment = .center
        let font =  UIFont.preferredFont(forTextStyle: .largeTitle)
        view.font = UIFont.systemFont(ofSize: font.pointSize, weight: .heavy)
        return view
    }()
    
    
    //MARK: Helper Functions
    func configureViewComponents() {
//        configureNavigationBar(title: "Home", buttonTitles: nil, buttonImages: ["camera", "photo"], selectors: [#selector(cameraTapped), #selector(photoLibraryTapped)], colors: [.systemBlue, .systemBlue])
        
        view.backgroundColor = .white
        
        view.addSubview(captureVC.view)
        captureVC.view.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: view.frame.height * (2/3))
        captureVC.start()
        
        view.addSubview(primaryLbl)
        primaryLbl.anchor(top: captureVC.view.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: SizeManager.padding, paddingLeft: SizeManager.padding, paddingBottom: SizeManager.padding, paddingRight: SizeManager.padding)
        
        
    }
    
    
    
    //MARK: Selectors
    
    
    @objc func cameraTapped() {
        ControllerManager.containerVC.cameraTapped()
    }
    @objc func photoLibraryTapped() {
        ControllerManager.containerVC.photoLibraryTapped()
    }
    
    
    
    
    
}

//MARK: Delegates
extension HomeVC: ClassificationDelegate {
    
    func classifiedFrame(bottleType: BottleType?, bottleType_all: BottleTypes_All?) {
        DispatchQueue.main.async {
            guard var text = bottleType?.rawValue ?? bottleType_all?.rawValue else { return }

            if let index = text.firstIndex(of: "_") {
                text = String(text.prefix(upTo: index))
            }
   
            self.currentBottleType = BottleType(rawValue: text)
            self.primaryLbl.text = text
        }
    }

}

//MARK: Delegates
extension HomeVC: ImageDependancyDelegate {
    func updateImage(image: UIImage) {
        self.imageView.image = image
        
        
        TextRecognitionManager.extractWords(from: image) { result in
            switch result {
            case .success(let words):
                print(words)
                let exactMap = LabelRecognitionManager.getRecognitionMap(words: words)
                
                print("EXACT MAP:", exactMap)
                guard let exactMatch = exactMap.max(by: { a, b in a.value.score < b.value.score }) else {
                    
                    let fuzzyMap = LabelRecognitionManager.getFuzzyRecognitionMap(words: words)
                    
                    print("FUZZY MAP:", fuzzyMap)
                    guard let fuzzyMatch = fuzzyMap.max(by: { a, b in a.value.score < b.value.score }) else {
                        self.primaryLbl.text = "NO MATCH"
                        return
                        
                    }
                    
                    print("HIGHEST FUZZY MATCH: \(fuzzyMatch)")
                    self.primaryLbl.text = "\(fuzzyMatch.key.rawValue), \(fuzzyMatch.value.score) fuzzy matches:\n\(fuzzyMatch.value.matches)"
                    
                    return
                }
                
                print("HIGHEST EXACT MATCH: \(exactMatch)")
                self.primaryLbl.text = "\(exactMatch.key.rawValue), \(exactMatch.value.score) exact matches:\n\(exactMatch.value.matches)"
                
                
                

            default:
                break
                
                
            }
        }
    }
}

