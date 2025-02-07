import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //configureToolbar()
    }
    
    func configureToolbar() {
        let toolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.barTintColor = UIColor.darkGray // Set the toolbar's background color
        toolbar.tintColor = UIColor.white // Set the color of the buttons

        // Create buttons for the toolbar
        let aboutButton = UIBarButtonItem(title: "About", style: .plain, target: self, action: #selector(didTapAbout))
        let cameraButton = UIBarButtonItem(title: "Camera", style: .plain, target: self, action: #selector(didTapCamera))

        // Add flexible space items to center the buttons
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        // Add buttons and flexible space to the toolbar
        toolbar.items = [flexibleSpace, aboutButton, flexibleSpace, cameraButton, flexibleSpace]
        
        // Add toolbar to the view
        view.addSubview(toolbar)
        
        
        // Set constraints for the toolbar
        NSLayoutConstraint.activate([
            toolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolbar.heightAnchor.constraint(equalToConstant: 80) // Set a fixed height
        ])
    }


    // MARK: Toolbar Selectors
    @objc func didTapAbout() {
        let vc = AboutVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapCamera() {
        let vc = ContainerVC()
        self.navigationController?.pushViewController(vc, animated: true)
        // Implement camera action
    }
    
}
