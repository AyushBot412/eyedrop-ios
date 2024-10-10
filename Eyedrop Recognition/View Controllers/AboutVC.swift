import UIKit


class AboutVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the background color to teal
        view.backgroundColor = UIColor(red: 63/255, green: 186/255, blue: 217/255, alpha: 1.0)

        // Optional: Add a title to the navigation bar
        self.title = "About"
        
        // "Our Mission" Label
               let ourMissionLabel = UILabel()
               ourMissionLabel.text = "Our Mission"
               ourMissionLabel.font = UIFont.boldSystemFont(ofSize: 24)
               ourMissionLabel.textColor = UIColor(named: "ourDarkerBlue")
               ourMissionLabel.translatesAutoresizingMaskIntoConstraints = false
               view.addSubview(ourMissionLabel)

               // "Mission Statement 1" Label
               let missionStatement1 = UILabel()
               missionStatement1.text = "The goal of the project is to develop a working IOS application that can correctly and efficiently describe eyedrop medication bottles."
               missionStatement1.font = UIFont.systemFont(ofSize: 24)
               missionStatement1.textColor = UIColor.black
               missionStatement1.numberOfLines = 0
               missionStatement1.translatesAutoresizingMaskIntoConstraints = false
               view.addSubview(missionStatement1)

               // Medicine Images (Circular with Stroke)
               
               //let medicineImageView = UIImageView(image: UIImage(named: "medicines_collage"))
               
                let medicineImageView = UIImageView()
                if let medicineImage = UIImage(named: "medicines_collage") {
                    medicineImageView.image = medicineImage
                } else {
                    print("Error: medicines_collage image not found")
                    medicineImageView.backgroundColor = .lightGray // Placeholder in case image is not found
                }
               medicineImageView.contentMode = .scaleAspectFit
               medicineImageView.layer.cornerRadius = 100
               medicineImageView.layer.masksToBounds = true
               medicineImageView.layer.borderColor = UIColor(named: "ourDarkerBlue")?.cgColor
               medicineImageView.layer.borderWidth = 7
               medicineImageView.translatesAutoresizingMaskIntoConstraints = false
               view.addSubview(medicineImageView)

               // "Mission Statement 2" Label
               let missionStatement2 = UILabel()
               missionStatement2.text = "The application uses advanced YOLOv6 models trained on a custom 10,000 image dataset to detect objects that match the required parameters and subsequently reads aloud the medicine name for patients with poor vision."
               missionStatement2.font = UIFont.systemFont(ofSize: 24)
               missionStatement2.textColor = UIColor.black
               missionStatement2.numberOfLines = 0
               missionStatement2.translatesAutoresizingMaskIntoConstraints = false
               view.addSubview(missionStatement2)

               // Constraints
               NSLayoutConstraint.activate([
                   ourMissionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
                   ourMissionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                   ourMissionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                   
                   missionStatement1.topAnchor.constraint(equalTo: ourMissionLabel.bottomAnchor, constant: 16),
                   missionStatement1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                   missionStatement1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                   
                   medicineImageView.topAnchor.constraint(equalTo: missionStatement1.bottomAnchor, constant: 16),
                   medicineImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                   medicineImageView.widthAnchor.constraint(equalToConstant: 200),
                   medicineImageView.heightAnchor.constraint(equalToConstant: 200),
                   
                   missionStatement2.topAnchor.constraint(equalTo: medicineImageView.bottomAnchor, constant: 16),
                   missionStatement2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                   missionStatement2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
               ])
           }
       }
