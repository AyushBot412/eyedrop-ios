//
//  ContainerVCModel.swift
//  Eyedrop Recognition
//
//  Created by Ludovico Veniani on 6/18/21.
//

import Foundation
import UIKit
class ContainerVCModel {
    let homeVC: HomeVC = {
        let VC = HomeVC()
        let NC = UINavigationController(rootViewController: VC)
        NC.modalPresentationStyle = .fullScreen
    
        VC.configureViewComponents()
        
        return VC
    }()
    
    lazy var cameraVC: CameraVC = {
        let VC = CameraVC()
        VC.delegate = VC
        VC.sourceType = .camera
        VC.allowsEditing = false
        return VC
    }()
    
}
