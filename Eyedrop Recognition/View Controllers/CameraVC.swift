//
//  ViewController.swift
//  Eyedrop Recognition
//
//  Created by Ludovico Veniani on 6/18/21.
//

import UIKit
import AVKit
import Photos

class CameraVC: UIImagePickerController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkCameraAuthorization()
    }
    
    //MARK: Variables
    weak var imageDelegate: ImageDependancyDelegate?
    
    //MARK: Views
    lazy var pickerController: UIImagePickerController = {
        let VC = UIImagePickerController()

        return VC
    }()
    
    //MARK: Helper Functions
    func checkCameraAuthorization() {
        if sourceType == .camera {
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
        case .authorized:

            // already authorized
            print()

        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { [unowned self] granted in
                if granted {
                    // Authorized
         
                } else {
                    // Not authorized
                    self.showAlert()
                    
                }
            })
        default:

            // already been asked. Denied access
            // Not authorized
            self.showAlert()
        }
        } else {
            let photos = PHPhotoLibrary.authorizationStatus()
            if photos == .notDetermined {
                PHPhotoLibrary.requestAuthorization({status in
                    if status == .authorized{
          
                    } else {
                        self.showAlert()
                    }
                })
            }
            }
    }
    
    

    func showAlert() {
        AlertManger.showAlert(title: "Camera Authorization Denied", message: "To use this app, please allow access to the camera in the settings.")
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK: Selectors
    
    
    


}

//MARK: Delegates
extension CameraVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage else { fatalError() }
        
        imageDelegate?.updateImage(image: image)
        

        
    }
}
