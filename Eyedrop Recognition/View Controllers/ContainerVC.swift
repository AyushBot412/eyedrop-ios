import UIKit

class ContainerVC: UIViewController {
    
    // MARK: Variables
    static let model = ContainerVCModel()
    
    var inHomeVC = false
    
    // MARK: Views
    var homeVC: HomeVC {
        ContainerVC.model.homeVC
    }
    
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
        
        // Add the scan bottle button
        view.addSubview(scanBottleButton)
        
        // Center the button in the view
        NSLayoutConstraint.activate([
            scanBottleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scanBottleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            scanBottleButton.widthAnchor.constraint(equalToConstant: 200),
            scanBottleButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Add target for button action
        scanBottleButton.addTarget(self, action: #selector(scanBottleTapped), for: .touchUpInside)
    }
    
    @objc private func scanBottleTapped() {
        // Transition to homeVC
        configureViewComponents()
        inHomeVC = true
    }
    
    func configureViewComponents() {
        view.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        
        // Remove homeVC from its previous parent if it exists
        
        
        // Add homeVC as a child view controller
        addChild(homeVC)
        view.addSubview(homeVC.view)
        homeVC.view.pinEdges(to: view) // Assuming you have this method to pin edges
        homeVC.didMove(toParent: self) // Notify homeVC that it was added
        self.homeVC.captureVC.start()
        
        // Remove the scan bottle button from the view
        scanBottleButton.removeFromSuperview()
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
