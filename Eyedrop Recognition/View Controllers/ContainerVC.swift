import UIKit

class ContainerVC: UIViewController {
    
    // MARK: Variables
    static let model = ContainerVCModel()
    var isQRCodeScan = false
    var inHomeVC = false
    
    // MARK: Views
    var homeVC: HomeVC {
        ContainerVC.model.homeVC
    }
    
    private let scanQRButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SCAN QR", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        button.backgroundColor = .white
        button.setTitleColor(UIColor(red: 63/255, green: 186/255, blue: 217/255, alpha: 1.0), for: .normal)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let scanBottleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SCAN BOTTLE", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        button.backgroundColor = .white
        button.setTitleColor(UIColor(red: 63/255, green: 186/255, blue: 217/255, alpha: 1.0), for: .normal)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ControllerManager.containerVC = self
        
        Constants.initialize(frame: view.frame)
        setupInitialView()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupInitialView()
        // Remove startApp() from viewDidAppear
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if(inHomeVC){
            self.homeVC.captureVC.stop()
        
        }
        
    }
    
    // MARK: Helper Functions
    private func setupInitialView() {
        if(inHomeVC){
            homeVC.view.removeFromSuperview()
            homeVC.removeFromParent()
        }
        
        inHomeVC = false
        view.backgroundColor = UIColor(red: 63/255, green: 186/255, blue: 217/255, alpha: 1.0)
        
        
        view.addSubview(scanQRButton)
        
        view.addSubview(scanBottleButton)
        
        NSLayoutConstraint.activate([
            scanQRButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scanQRButton.bottomAnchor.constraint(equalTo: scanBottleButton.topAnchor, constant: -20), // Adjust the space
            scanQRButton.widthAnchor.constraint(equalToConstant: 200),
            scanQRButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Center the scanBottleButton in the view
            scanBottleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scanBottleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            scanBottleButton.widthAnchor.constraint(equalToConstant: 200),
            scanBottleButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Add target for scanQRButton action
        scanQRButton.addTarget(self, action: #selector(scanQRTapped), for: .touchUpInside)
        
        // Add target for scanBottleButton action
        scanBottleButton.addTarget(self, action: #selector(scanBottleTapped), for: .touchUpInside)
    }
    
    @objc private func scanBottleTapped() {
        // Transition to homeVC
        isQRCodeScan = false
        configureViewComponents()
        inHomeVC = true
        
        
    }
    
    @objc private func scanQRTapped() {
        // Transition to homeVC
        isQRCodeScan = true
        configureViewComponents()
        inHomeVC = true
        print("in scanQRTapped")
    }
    
    func configureViewComponents() {
        view.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        
        
        ContainerVC.model.homeVC.isQRCodeScan = isQRCodeScan
        
        // Add homeVC as a child view controller
        addChild(homeVC)
        view.addSubview(homeVC.view)
        homeVC.view.pinEdges(to: view) // Assuming you have this method to pin edges
        homeVC.didMove(toParent: self) // Notify homeVC that it was added
        
        homeVC.configureViewComponents()
        self.homeVC.captureVC.start(isQRCodeScan: self.isQRCodeScan)
        
        // Remove the scan bottle button from the view
        scanBottleButton.removeFromSuperview()
        scanQRButton.removeFromSuperview()
    }

    
    // MARK: Selectors
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


// MARK: Delegates
