//
//  PrescriptionDetailVC.swift
//  Eyedrop Recognition
//
//  Created by Elise Jang on 5/9/25.
//

import Foundation
import UIKit

class PrescriptionDetailVC: UIViewController {
    
    var prescription: Prescription!
    
    // Add labels to display prescription details
    var medicineL: UILabel!
    var frequencyL: UILabel!
    var eyeSelectionL: UILabel!
    var capColorL: UILabel!
    var specialInstructionL: UILabel!
    var medicineNameLabel: UILabel!
    var frequencyLabel: UILabel!
    var eyeSelectionLabel: UILabel!
    var capColorLabel: UILabel!
    var specialInstructionLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(prescription)

        view.backgroundColor = .white
        
        setupNavigationBar()
        
        // Set up UI elements to display detailed information
        frequencyL = UILabel()
        eyeSelectionL = UILabel()
        capColorL = UILabel()
        specialInstructionL = UILabel()
        
        medicineNameLabel = UILabel()
        frequencyLabel = UILabel()
        eyeSelectionLabel = UILabel()
        capColorLabel = UILabel()
        specialInstructionLabel = UILabel()
        
        
        frequencyL.text = "Frequency:"
        eyeSelectionL.text = "Eye Selection:"
        capColorL.text = "Cap Color:"
        specialInstructionL.text = "Special Instructions:"
        
        medicineNameLabel.text = "\(prescription.medicineName)"
        frequencyLabel.text = "\(prescription.frequency)"
        eyeSelectionLabel.text = "\(getSelectedEyes(prescription.eyeSelection))"
        capColorLabel.text = "\(prescription.capColor)"
        specialInstructionLabel.text = "\(prescription.specialInstruction)"
        
        medicineNameLabel.textColor = UIColor.systemBlue // Blue for emphasis
        frequencyL.textColor = UIColor.systemBlue
        eyeSelectionL.textColor = UIColor.systemBlue
        capColorL.textColor = UIColor.systemBlue
        specialInstructionL.textColor = UIColor.systemBlue
        
        frequencyLabel.textColor = .black
        eyeSelectionLabel.textColor = .black
        capColorLabel.textColor = .black
        specialInstructionLabel.textColor = .black
        
        // Increase font size for better readability
        let largeFont = UIFont.boldSystemFont(ofSize: 50)
        let mediumFont = UIFont.boldSystemFont(ofSize: 30)
        let smallFont = UIFont.systemFont(ofSize: 20)
        
        medicineNameLabel.font = largeFont
        frequencyL.font = mediumFont
        frequencyLabel.font = smallFont
        eyeSelectionL.font = mediumFont
        eyeSelectionLabel.font = smallFont
        capColorL.font = mediumFont
        capColorLabel.font = smallFont
        specialInstructionL.font = mediumFont
        specialInstructionLabel.font = smallFont
        
        // Add padding between the labels
        frequencyL.lineBreakMode = .byWordWrapping
        eyeSelectionL.lineBreakMode = .byWordWrapping
        capColorL.lineBreakMode = .byWordWrapping
        specialInstructionL.lineBreakMode = .byWordWrapping
        medicineNameLabel.lineBreakMode = .byWordWrapping
        frequencyLabel.lineBreakMode = .byWordWrapping
        eyeSelectionLabel.lineBreakMode = .byWordWrapping
        capColorLabel.lineBreakMode = .byWordWrapping
        specialInstructionLabel.lineBreakMode = .byWordWrapping

        // Create a stack view to arrange the labels vertically
        let stackView = UIStackView(arrangedSubviews: [medicineNameLabel, frequencyL, frequencyLabel, eyeSelectionL, eyeSelectionLabel, capColorL,capColorLabel, specialInstructionL, specialInstructionLabel])
        stackView.axis = .vertical
        stackView.spacing = 30 // Increase space between labels
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add stack view to the view
        view.addSubview(stackView)
        
        // Apply constraints to the stack view
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }

    private func getSelectedEyes(_ eyeSelection: EyeSelection) -> String {
        var selectedEyes = [String]()
        if eyeSelection.left {
            selectedEyes.append("Left")
        }
        if eyeSelection.right {
            selectedEyes.append("Right")
        }
        if eyeSelection.both {
            selectedEyes.append("Both")
        }
        return selectedEyes.isEmpty ? "None" : selectedEyes.joined(separator: ", ")
    }
    
    private func setupNavigationBar() {
        
        // Back button is handled automatically if using NavigationController
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemBlue

        // Edit and Delete buttons
        let deleteButton = UIBarButtonItem(
            image: UIImage(systemName: "trash"),
            style: .plain,
            target: self,
            action: #selector(didTapDelete)
        )
        
        let editButton = UIBarButtonItem(
            image: UIImage(systemName: "pencil"),
            style: .plain,
            target: self,
            action: #selector(didTapEdit)
        )
        
        navigationItem.rightBarButtonItems = [deleteButton, editButton]
    }
    
    @objc private func didTapEdit() {
        let alert = UIAlertController(
                title: "Edit medicine?",
                message: "Only edit medicine if instructed by a healthcare professional.",
                preferredStyle: .alert
            )

            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { _ in
//                self.presentEditScreen()
                //add EDIT FUNCTIONALITY
            }))

            present(alert, animated: true, completion: nil)
        }

    @objc private func didTapDelete() {
        let alert = UIAlertController(
                title: "Delete medicine?",
                message: "Only delete medicine if instructed by a healthcare professional.",
                preferredStyle: .alert
            )

            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { _ in
                self.deletePrescription()
            }))

            present(alert, animated: true, completion: nil)
        }
    
    private func deletePrescription() {
        // Example: Notify a delegate or post a notification to update the list
        NotificationCenter.default.post(
            name: Notification.Name("PrescriptionDeleted"),
            object: prescription
        )

        // Optionally show a quick toast/alert
        let deletedAlert = UIAlertController(title: nil, message: "Prescription deleted.", preferredStyle: .alert)
        self.present(deletedAlert, animated: true)

        // Dismiss the alert after a short delay and pop the view
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            deletedAlert.dismiss(animated: true) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

