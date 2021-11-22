//
//  ViewController.swift
//  Eyedrop Recognition
//
//  Created by Ludovico Veniani on 6/18/21.
//

import UIKit

class ContainerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ControllerManager.containerVC = self
        
        Constants.initialize(frame: view.frame)
        startApp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.homeVC.captureVC.start()
    }
    
    //MARK: Variables
    static let model = ContainerVCModel()
    
    
    //MARK: Views
    var homeVC: HomeVC {
        ContainerVC.model.homeVC
    }
    
    //MARK: Helper Functions
    func startApp() {
        configureViewComponents()
    }
    func configureViewComponents() {
        view.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(homeVC.view)
        homeVC.view.pinEdges(to: view)
        
    }
    
    //MARK: Selectors
    
    func cameraTapped() {
        Self.model.cameraVC.imageDelegate = Self.model.homeVC
        Self.model.cameraVC.sourceType = .camera
        self.present(Self.model.cameraVC, animated: true, completion: nil)
    }
    
    func photoLibraryTapped() {
        Self.model.cameraVC.imageDelegate = Self.model.homeVC
        Self.model.cameraVC.sourceType = .photoLibrary
        self.present(Self.model.cameraVC, animated: true, completion: nil)
    }
    


}

//MARK: Delegates

