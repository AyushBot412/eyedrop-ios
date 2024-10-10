import UIKit
import AVFoundation

class HomeVC: UIViewController {
    var i = 0
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents() // Call the configure function to set up the view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    

    
    // MARK: Variables
    
    var player: AVAudioPlayer!
    
    var currentBottleType: BottleType? {
        didSet {
            if oldValue != self.currentBottleType {
                let fileName = self.currentBottleType?.rawValue.lowercased()
                print(fileName as Any)
                guard let pathToSound = Bundle.main.path(forResource: fileName, ofType: "mp3"),
                      let url = URL(string: pathToSound) else { return }
                
                print(url)
                
                do {
                    player = try AVAudioPlayer(contentsOf: url)
                    player?.play()
                } catch {
                    print("Error playing sound.")
                }
            }
        }
    }
    
    // MARK: Views
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
    
    let primaryButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal) // Initial title color
        button.setTitle("Hold Camera Towards \n the Medicine Bottle", for: .normal) // Set the title as needed
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 2
        button.backgroundColor = UIColor(red: 63/255, green: 186/255, blue: 217/255, alpha: 1.0) // Initial background color
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .heavy) // Set the font size to 25
        button.isUserInteractionEnabled = false // Make it non-functional
        button.layer.cornerRadius = 35 // Rounded corners
        button.clipsToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20) // Add some padding
        return button
    }()
    
    // Dictionary to map bottle types to their corresponding background colors
    let bottleColors: [BottleType: UIColor] = [
        .ALPHAGAN: UIColor(red: 128/255, green: 0/255, blue: 128/255, alpha: 1.0), // #800080
        .COMBIGAN: UIColor(red: 144/255, green: 238/255, blue: 144/255, alpha: 1.0), // #90EE90
        .DORZOLAMIDE: UIColor(red: 255/255, green: 165/255, blue: 0/255, alpha: 1.0), // #FFA500
        .LATANOPROST: UIColor(red: 64/255, green: 224/255, blue: 208/255, alpha: 1.0), // #40E0D0
        .PREDFORTE: UIColor(red: 255/255, green: 192/255, blue: 203/255, alpha: 1.0), // #FFC0CB
        .RHOPRESSA: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0), // #FFFFFF
        .ROCKLATAN: UIColor(red: 0/255, green: 149/255, blue: 76/255, alpha: 1.0), // #00954C
        .VIGAMOX: UIColor(red: 207/255, green: 178/255, blue: 125/255, alpha: 1.0) // #CFB27D
    ]
    
    // MARK: Helper Functions
    func configureViewComponents() {
        view.backgroundColor = .clear
        
        
        
        view.addSubview(captureVC.view)
        captureVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            captureVC.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 60), // Set to the top of the view with padding
            captureVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            captureVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            captureVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor) // Optional: Adjust as needed
        ])
        captureVC.start()
        
        view.addSubview(primaryButton)
        primaryButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            primaryButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 0), // Set width to minimum required
            primaryButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 40), // Minimum height
            primaryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            primaryButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height * 0.2) // Centered in the bottom 40%
        ])
    }
    
    // Function to get the complementary color
    func complementaryColor(for color: UIColor) -> UIColor {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        // Get the RGBA components of the color
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        // Calculate the complementary color
        return UIColor(red: 1 - r, green: 1 - g, blue: 1 - b, alpha: a)
    }

}

// MARK: Delegates
extension HomeVC: ClassificationDelegate {
    func classifiedFrame(bottleType: BottleType?, bottleType_all: BottleTypes_All?) {
        DispatchQueue.main.async {
            guard var text = bottleType?.rawValue ?? bottleType_all?.rawValue else { return }

            if let index = text.firstIndex(of: "_") {
                text = String(text.prefix(upTo: index))
            }

            self.currentBottleType = BottleType(rawValue: text)
            self.primaryButton.setTitle(text, for: .normal)
            
            // Change button background color based on bottle type
            if let bottleType = self.currentBottleType {
                let newColor = self.bottleColors[bottleType] ?? UIColor(red: 1.0, green: 0.47, blue: 0.42, alpha: 1.0) // Default to salmon pink if not found
                self.primaryButton.backgroundColor = newColor
                
                // Set the title color to the complementary color
                self.primaryButton.setTitleColor(self.complementaryColor(for: newColor), for: .normal)
            }
        }
    }
}

// MARK: Delegates
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
                        self.primaryButton.setTitle("NO MATCH", for: .normal)
                        return
                    }

                    print("HIGHEST FUZZY MATCH: \(fuzzyMatch)")
                    self.primaryButton.setTitle("\(fuzzyMatch.key.rawValue), \(fuzzyMatch.value.score) fuzzy matches:\n\(fuzzyMatch.value.matches)", for: .normal)
                    return
                }

                print("HIGHEST EXACT MATCH: \(exactMatch)")
                self.primaryButton.setTitle("\(exactMatch.key.rawValue), \(exactMatch.value.score) exact matches:\n\(exactMatch.value.matches)", for: .normal)

            default:
                break
            }
        }
    }
}
