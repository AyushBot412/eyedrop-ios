//
//  CaptureVC.swift
//  Eyedrop Recognition
//
//  Created by Ludovico Veniani on 8/11/21.
//



import UIKit

import AVFoundation
import AVKit
import CoreMedia
import NextLevel
import Photos
//import YPImagePicker


internal let hasNotch = UIDevice.current.hasNotch
class CaptureVC: UIViewController {
    // MARK: Intrinsic

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        

    }
    


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)

        nextLevel.configureAutoFocusMode()
        nextLevel.videoZoomFactor = 0


    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nextLevel.flashMode = flashEnabled ? .on : .off
        nextLevel.torchMode = flashEnabled ? .on : .off
        

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        nextLevel.flashMode = .off
        nextLevel.torchMode = .off

    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    // MARK: Variables
    let model = NEW_mnetv3__d__trainable_withMoreAug_0_0001lr_224_dim_32_bs_10_epochs_0_6_droput_0_9613970518112183_acc_h5()
    var lastClassification: Date?
    let nextLevel = NextLevel.shared
    var flashEnabled = false
    var hasVideoAccess = false
    var didConfigureViews = false
    var isClassifying = false
    
    public var startLocation: CGPoint!
    public var startedZoom = false
    public var previousPanTranslation: CGFloat = 0.0
    public var beginZoomScale = CGFloat(1.0)
    
    var pastBrightness: CGFloat = UIScreen.main.brightness
    var pan: UIPanGestureRecognizer!
    var swipe: UISwipeGestureRecognizer!
    
    lazy var buttonWidth = view.frame.width / 8
    lazy var buttonWidthMargin = buttonWidth / 4
    
    weak var classificationDelegate: ClassificationDelegate?
    
    // MARK: Views
    let previewView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = hasNotch ? 0 : 0
        return view
    }()
    
    lazy var flashButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "bolt", withConfiguration: nil), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(toggleFlashTapped), for: [.touchDragInside, .touchUpInside])
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        btn.layer.shadowOpacity = 0.35
        btn.layer.shadowRadius = 3
        btn.layer.masksToBounds = true
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return btn
    }()
    
    let frontFlash: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.isUserInteractionEnabled = false
        return view
    }()
    
    lazy var photoLibrary: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.imageView?.contentMode = .scaleAspectFill
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        btn.layer.shadowOpacity = 0.35
        btn.layer.shadowRadius = 3
        btn.layer.masksToBounds = true
        btn.clipsToBounds = true
        return btn
    }()
    
    
    // MARK: Helper functions
    func start() {
        self.checkAuthorization()
    }
    
    func setup(accessGranted: Bool) {
        DispatchQueue.main.async {
            if !self.didConfigureViews {
                self.didConfigureViews = true

                self.configurePreviewView()

                if accessGranted {
                    self.configureNextLevel()
                }

                self.configureViewComponents()
            }
        }
    }

    func checkAuthorization() {
        // Test authorization status for Camera and Micophone

        checkCameraAuthorization()
        checkMicrophoneAuthorization()
    }

    func checkCameraAuthorization() {
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
        case .authorized:

            // already authorized
            //            self.setup(accessGranted: true)
            hasVideoAccess = true
            checkMicrophoneAuthorization()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { [unowned self] granted in
                if granted {
                    // Authorized
                    //                    self.setup(accessGranted: true)
                    self.hasVideoAccess = true
                    self.checkMicrophoneAuthorization()
                } else {
                    // Not authorized
                    //                    self.setup(accessGranted: false)
                    //                    self.showAlert()
                    self.hasVideoAccess = false
                    self.checkMicrophoneAuthorization()
                }
            })
        default:

            // already been asked. Denied access
            // Not authorized
            //            self.setup(accessGranted: false)
            //            self.showAlert()
            hasVideoAccess = false
            checkMicrophoneAuthorization()
        }
    }

    func checkMicrophoneAuthorization() {
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            if granted {
                // The user granted access. Present recording interface.
                self.setup(accessGranted: self.hasVideoAccess)
            } else {
                // Present message to user indicating that recording
                // can't be performed until they change their preference
                self.setup(accessGranted: false)
                self.showAlert()
            }
        }
    }



    func showAlert() {
        //            let alertController = UIAlertController(title: "Unable to Access Camera", message: "Enable camera permissions for Rage in your device settings.", preferredStyle: .alert)
        //            present(alertController, animated: true)

        DispatchQueue.main.async { [unowned self] in
            let message = NSLocalizedString("This app doesn't have permission to use the camera and microphone, change camera settings to continue.", comment: "Alert message when the user has denied access to the camera")
            let alertController = UIAlertController(title: "Unable to Access Camera", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"), style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: NSLocalizedString("Settings", comment: "Alert button to open Settings"), style: .default, handler: { _ in
                if #available(iOS 10.0, *) {
                    UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
                } else {
                    if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.openURL(appSettings)
                    }
                }
            }))
            self.present(alertController, animated: true, completion: nil)
        }
    }

    func configurePreviewView() {
        view.addSubview(previewView)

        previewView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: min(view.frame.width * (16 / 9), view.frame.height))
    }

    func configureViewComponents() {

        view.addSubview(flashButton)


        view.addSubview(photoLibrary)
        view.addSubview(frontFlash)


        let hasNotch = UIDevice.current.hasNotch

        flashButton.anchor(top: hasNotch ? nil : view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: hasNotch ? view.safeAreaLayoutGuide.bottomAnchor : nil, right: hasNotch ? nil : view.rightAnchor, centerX: hasNotch ? view.centerXAnchor : nil, paddingTop: SizeManager.padding, paddingLeft: 0, paddingBottom: SizeManager.padding, paddingRight: SizeManager.padding, width: buttonWidth, height: buttonWidth)
        flashButton.imageView?.anchor(top: flashButton.topAnchor, left: flashButton.leftAnchor, bottom: flashButton.bottomAnchor, right: flashButton.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)

   

        frontFlash.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)

        
        addGestures()
    }
    
    func getLastImageFromPhotoLibrary() {
        var lastVideo: UIImage?
        var lastPicture: UIImage?

        // Get last video
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        if let fetchResult = PHAsset.fetchAssets(with: .video, options: fetchOptions).lastObject {
            PHImageManager().requestAVAsset(forVideo: fetchResult, options: nil, resultHandler: { avurlAsset, _, _ in
                let imgGenerator = AVAssetImageGenerator(asset: avurlAsset!)
                let cgImage = try? imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)

                if let cgImage = cgImage {
                    lastVideo = UIImage(cgImage: cgImage)
                }
            })
        }

        // Get last picture
        if let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions).lastObject {
            PHImageManager().requestImage(for: fetchResult, targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFit, options: nil, resultHandler: { image, _ in
                lastPicture = image
            })
        }

        DispatchQueue.main.async {
            if let lastPicture = lastPicture {
                self.photoLibrary.setImage(lastPicture, for: .normal)
            } else if let lastVideo = lastVideo {
                self.photoLibrary.setImage(lastVideo, for: .normal)
            } else {
                self.photoLibrary.setImage(#imageLiteral(resourceName: "gray"), for: .normal)
            }
        }
    }

    func configureNextLevel() {
        view.layoutIfNeeded()

        previewView.backgroundColor = UIColor.black
        nextLevel.previewLayer.frame = previewView.bounds
        previewView.layer.addSublayer(nextLevel.previewLayer)

        nextLevel.delegate = self
        nextLevel.videoDelegate = self

        nextLevel.captureMode = .video


        nextLevel.flashMode = .off
        nextLevel.torchMode = .off

        // video configuration
        nextLevel.videoStabilizationMode = .auto
        nextLevel.videoConfiguration.maximumCaptureDuration = CMTime(seconds: 60, preferredTimescale: 1)
        nextLevel.session?.fileType = .mp4

        nextLevel.videoConfiguration.aspectRatio = .instagramStories
//        nextLevel.videoConfiguration.dimensions = CGSize(width: 1080, height: 1920)
        nextLevel.videoConfiguration.bitRate = 10_000_000
        nextLevel.videoConfiguration.preset = .high
        nextLevel.videoConfiguration.maxKeyFrameInterval = 24
        nextLevel.frameRate = 24
        nextLevel.videoConfiguration.codec = .hevc
        //        nextLevel.mirroringMode = .auto



        // audio configuration

        let settings = [AVFormatIDKey: kAudioFormatMPEG4AAC,
                        AVNumberOfChannelsKey: 2,
                        AVSampleRateKey: 44100.0] as [String: Any]

        nextLevel.audioConfiguration.options = settings

        nextLevel.automaticallyConfiguresApplicationAudioSession = true
        try? nextLevel.start()
    }

    

    func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(screenTapped(sender:)))
        previewView.addGestureRecognizer(tap)

  

        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(screenPinched(sender:)))
        pinch.delegate = self
        previewView.addGestureRecognizer(pinch)

        let pan = UIPanGestureRecognizer(target: self, action: #selector(screenPanned(sender:)))
        previewView.addGestureRecognizer(pan)


        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeUp(sender:)))
        swipe.direction = .up
        swipe.delegate = self
        previewView.addGestureRecognizer(swipe)
    }
    
    
    fileprivate func focusAnimationAt(_ point: CGPoint) {
        let focusView = UIImageView(image: UIImage(systemName: "camera.aperture"))
        focusView.tintColor = .white
        focusView.center = point
        focusView.alpha = 0.0
        previewView.addSubview(focusView)

        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
            focusView.alpha = 1.0
            focusView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }) { _ in
            UIView.animate(withDuration: 0.15, delay: 0.5, options: .curveEaseInOut, animations: {
                focusView.alpha = 0.0
                focusView.transform = CGAffineTransform(translationX: 0.6, y: 0.6)
            }) { _ in
                focusView.removeFromSuperview()
            }
        }
    }

    fileprivate func toggleFlashAnimation() {
        if flashEnabled {
            flashButton.setImage(UIImage(systemName: "bolt.fill"), for: .normal)
        } else {
            flashButton.setImage(UIImage(systemName: "bolt"), for: .normal)
        }
    }
    
    var currentImageFrame: UIImage!
    func processImage(image: UIImage) {
        self.currentImageFrame  = image
        DispatchQueue.global(qos: .userInitiated).async { [weak image] in
            guard !self.isClassifying, let image = image else { return }
            self.isClassifying = true
            
            var classifiedBottleType: BottleType?
            
    
            TextRecognitionManager.extractWords(from: image) { result in
                switch result {
                case .success(let words):
                    if let exactMatch = LabelRecognitionManager.getRecognitionMap(words: words).max(by: { a, b in a.value.score < b.value.score }) {
                        classifiedBottleType = exactMatch.key

                    } else if let fuzzyMatch = LabelRecognitionManager.getFuzzyRecognitionMap(words: words).max(by: { a, b in a.value.score < b.value.score }) {
                        classifiedBottleType = fuzzyMatch.key
                    }
                    
                case .failure(_):
                    break
                }
                
                if let textClassifiedBottleType = classifiedBottleType {
                    //Settle on text processing
                    self.classificationDelegate?.classifiedFrame(bottleType: textClassifiedBottleType, bottleType_all: nil)
                    self.isClassifying = false
                } else {
                    //Use image classification model
                    self.beginModelPrediction(image: image)
                }
                
                
                
            }
        }
    }
    
    func beginModelPrediction(image: UIImage) {
        let methodStart = NSDate()
        
        
        // 224x224 inputs for mobilenet
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 224, height: 224), true, 2.0)
        image.draw(in: CGRect(x: 0, y: 0, width: 224, height: 224))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer : CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(newImage.size.width), Int(newImage.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        guard (status == kCVReturnSuccess) else {
            self.isClassifying = false
            return
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pixelData, width: Int(newImage.size.width), height: Int(newImage.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue) //3
        
        context?.translateBy(x: 0, y: newImage.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        UIGraphicsPushContext(context!)
        newImage.draw(in: CGRect(x: 0, y: 0, width: newImage.size.width, height: newImage.size.height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
 
        
        // Make prediction
        guard let prediction = try? model.prediction(MobilenetV3large_input: pixelBuffer!), let confidence = prediction.Identity[prediction.classLabel] else {
            self.isClassifying = false
            return
        }
        
        let executionTime = NSDate().timeIntervalSince(methodStart as Date)
        print("Execution time: \(executionTime)")
        
    
        let confidenceString = String(format:"%.2f", confidence*100)
        print("\(prediction.classLabel) (with \(confidenceString)% confidence).")
        
        guard confidence > 0.8 else {
            self.isClassifying = false
            return
        }
        
        let bottleType_all = BottleTypes_All(rawValue: prediction.classLabel)!
        
        self.classificationDelegate?.classifiedFrame(bottleType: nil, bottleType_all: bottleType_all)
        self.isClassifying = false
    }
    
    // MARK: Selectors
    @objc func screenTapped(sender: UITapGestureRecognizer) {
        let location = sender.location(in: previewView)
        let focusPoint = nextLevel.previewLayer.captureDevicePointConverted(fromLayerPoint: location)
        nextLevel.focusExposeAndAdjustWhiteBalance(atAdjustedPoint: focusPoint)

        let tapPoint = sender.location(in: previewView)
        focusAnimationAt(tapPoint)
    }
    
    @objc func screenPinched(sender: UIPinchGestureRecognizer) {
        nextLevel.videoZoomFactor = Float(beginZoomScale * sender.scale)
    }

    @objc func didSwipeUp(sender _: UISwipeGestureRecognizer) {
       
    }

    @objc func screenPanned(sender: UIPanGestureRecognizer) {
        print("&&&&&", sender.velocity(in: previewView).y)

 
        

        let currentTranslation = sender.translation(in: previewView).y
        let translationDifference = Float(currentTranslation - previousPanTranslation)

        let currentZoom = nextLevel.videoZoomFactor

        nextLevel.videoZoomFactor = currentZoom - (translationDifference / 75)

        if sender.state == .ended || sender.state == .failed || sender.state == .cancelled {
            previousPanTranslation = 0.0
        } else {
            previousPanTranslation = currentTranslation
        }
    }
    
    @objc func toggleFlashTapped(_: Any) {
        print(nextLevel.flashMode.rawValue)
        print(nextLevel.torchMode.rawValue)

        nextLevel.flashMode = flashEnabled ? .off : .on
        nextLevel.torchMode = flashEnabled ? .off : .on

        flashEnabled.toggle()
        toggleFlashAnimation()

    }



}


//MARK: -Gesture delegate
extension CaptureVC: UIGestureRecognizerDelegate {
    /// Set beginZoomScale when pinch begins

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isKind(of: UIPinchGestureRecognizer.self) {
            beginZoomScale = CGFloat(nextLevel.videoZoomFactor)
        }
        return true
    }
}



//MARK: -Next level video delegate
extension CaptureVC: NextLevelVideoDelegate {
    // video zoom
    public func nextLevel(_: NextLevel, didUpdateVideoZoomFactor videoZoomFactor: Float) {
    }

    // video frame processing
    public func nextLevel(_: NextLevel, willProcessRawVideoSampleBuffer sampleBuffer: CMSampleBuffer, onQueue _: DispatchQueue) {
        
        guard !self.isClassifying else { return }

        
        if let lastClassification = self.lastClassification {
            guard Date().nanoseconds(from: lastClassification) > 500_000_000 else { return }
        }
        self.lastClassification = Date()
       
        
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
                debugPrint("unable to get image from sample buffer")
                return
            }
        
        let image = CIImage(cvPixelBuffer: imageBuffer).convert()
        
        self.processImage(image: image)

        
        
    }

    public func nextLevel(_: NextLevel, willProcessFrame _: AnyObject, timestamp _: TimeInterval, onQueue _: DispatchQueue) {}

    // enabled by isCustomContextVideoRenderingEnabled
    public func nextLevel(_: NextLevel, renderToCustomContextWithImageBuffer _: CVPixelBuffer, onQueue _: DispatchQueue) {}

    // video recording session

    public func nextLevel(_: NextLevel, didSetupVideoInSession _: NextLevelSession) {}

    public func nextLevel(_: NextLevel, didSetupAudioInSession _: NextLevelSession) {}

    public func nextLevel(_: NextLevel, didStartClipInSession _: NextLevelSession) {}

    public func nextLevel(_: NextLevel, didCompleteClip _: NextLevelClip, inSession _: NextLevelSession) {}

    public func nextLevel(_: NextLevel, didAppendVideoSampleBuffer _: CMSampleBuffer, inSession _: NextLevelSession) {}

    public func nextLevel(_: NextLevel, didAppendAudioSampleBuffer _: CMSampleBuffer, inSession _: NextLevelSession) {}

    public func nextLevel(_: NextLevel, didAppendVideoPixelBuffer _: CVPixelBuffer, timestamp _: TimeInterval, inSession _: NextLevelSession) {}

    public func nextLevel(_: NextLevel, didSkipVideoPixelBuffer _: CVPixelBuffer, timestamp _: TimeInterval, inSession _: NextLevelSession) {}

    public func nextLevel(_: NextLevel, didSkipVideoSampleBuffer _: CMSampleBuffer, inSession _: NextLevelSession) {}

    public func nextLevel(_: NextLevel, didSkipAudioSampleBuffer _: CMSampleBuffer, inSession _: NextLevelSession) {}

    public func nextLevel(_: NextLevel, didCompleteSession _: NextLevelSession) {}

    public func nextLevel(_ nextLevel: NextLevel, didCompletePhotoCaptureFromVideoFrame photoDict: [String: Any]?) {}
}


extension CaptureVC: NextLevelDelegate {
    public func nextLevel(_: NextLevel, didUpdateAuthorizationStatus _: NextLevelAuthorizationStatus, forMediaType _: AVMediaType) {}

    // configuration
    public func nextLevel(_: NextLevel, didUpdateVideoConfiguration _: NextLevelVideoConfiguration) {
    }

    public func nextLevel(_: NextLevel, didUpdateAudioConfiguration _: NextLevelAudioConfiguration) {}

    // session
    public func nextLevelSessionWillStart(_: NextLevel) {
        #if PROTOTYPE
            TinyConsole.print("📷 will start")
        #endif
    }

    public func nextLevelSessionDidStart(_ nextLevel: NextLevel) {
        print("Session did start running")
        nextLevel.session?.fileType = .mp4
    }

    public func nextLevelSessionDidStop(_: NextLevel) {
    }

    // session interruption
    public func nextLevelSessionWasInterrupted(_: NextLevel) {
    }

    public func nextLevelSessionInterruptionEnded(_: NextLevel) {}

    // preview
    public func nextLevelWillStartPreview(_: NextLevel) {}

    public func nextLevelDidStopPreview(_: NextLevel) {}

    // mode
    public func nextLevelCaptureModeWillChange(_: NextLevel) {}

    public func nextLevelCaptureModeDidChange(_: NextLevel) {}
}
