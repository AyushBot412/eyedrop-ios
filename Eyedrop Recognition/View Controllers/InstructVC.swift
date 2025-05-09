//
//  InstructVC.swift
//  Eyedrop Recognition
//
//  Created by Elise Jang on 3/14/25.
//

import UIKit
import SwiftUI

class InstructVC: UIViewController {
//    let viewModel = PrescriptionViewModel()
    var sampleprescriptions: [Prescription] = []
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
        Constants.initialize(frame: view.frame)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .white
        setupPrescriptionCard()
        setupUI()
//        setupSwiftUIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupUI()
    }
    
    private func setupUI() {
        configureTopBar()
        configurePresciptions()
    }
    
    func configureTopBar() {
        let topBar = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 90))
                topBar.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.8)

        let titleLabel = UILabel(frame: CGRect(x: 0, y: topBar.frame.height - 40, width: view.frame.width, height: 40))
        titleLabel.text = "EyeD Identifier"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        
        topBar.addSubview(titleLabel)
        view.addSubview(topBar)
        
        let infoButton = UIButton(frame: CGRect(x: view.frame.width - 80, y: topBar.frame.height - 40, width: 30, height: 40))
        infoButton.tintColor = .white
        infoButton.setImage(UIImage(systemName: "info.circle"), for: .normal)
        infoButton.addTarget(self, action: #selector(didTapInfo), for: .touchUpInside)

    
        let menuButton = UIButton(frame: CGRect(x: view.frame.width - 40, y: topBar.frame.height - 40, width: 30, height: 40))
        menuButton.tintColor = .white
        menuButton.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        menuButton.addTarget(self, action: #selector(didTapMenu), for: .touchUpInside)

        topBar.addSubview(titleLabel)
        topBar.addSubview(infoButton)
        topBar.addSubview(menuButton)
        view.addSubview(topBar)
    }
    
    func configurePresciptions() {
        //
    }
    
    // Function to set prescriptions data
    func updatePrescriptions(with prescriptions: [Prescription]) {
        self.sampleprescriptions = prescriptions
        // You can update the UI or refresh the view as necessary
        print(sampleprescriptions)
    }
    
//    private func setupSwiftUIView() {
//        let swiftUIView = PrescriptionListView(viewModel: viewModel)
//        let hostingController = UIHostingController(rootView: swiftUIView)
//
//        addChild(hostingController)
//        hostingController.view.frame = CGRect(x: 0, y: 90, width: view.frame.width, height: view.frame.height - 90)
//        view.addSubview(hostingController.view)
//        hostingController.didMove(toParent: self)
//    }
    
    // Function to set up a simple card to display prescription details
      private func setupPrescriptionCard() {
          // Example Prescription data
          let prescription = Prescription(
              id: 1,
              uniqueKey: "e10d0d87-006a-48c5-bcfa-933365e42db3",
              medicineName: "TimololEXAMPLE",
              eyeSelection: EyeSelection(left: true, right: false, both: false),
              frequency: "1 time/Day",
              capColor: "Blue",
              specialInstruction: "N/A"
          )
          
          // Create a card view
          let cardView = UIView()
          cardView.backgroundColor = .lightGray
          cardView.layer.cornerRadius = 10
          cardView.layer.masksToBounds = true
          cardView.translatesAutoresizingMaskIntoConstraints = false
          
          // Add the card view to the main view
          view.addSubview(cardView)
          
          // Set up constraints for the card view
          NSLayoutConstraint.activate([
              cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
              cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
              cardView.widthAnchor.constraint(equalToConstant: 300),
              cardView.heightAnchor.constraint(equalToConstant: 300)
          ])
          
          // Create and add the medicine name label
          let medicineNameLabel = UILabel()
          medicineNameLabel.text = "Medicine: \(prescription.medicineName)"
          medicineNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
          medicineNameLabel.textColor = .black
          medicineNameLabel.translatesAutoresizingMaskIntoConstraints = false
          cardView.addSubview(medicineNameLabel)
          
          // Create and add the frequency label
          let frequencyLabel = UILabel()
          frequencyLabel.text = "Frequency: \(prescription.frequency)"
          frequencyLabel.font = UIFont.systemFont(ofSize: 14)
          frequencyLabel.textColor = .black
          frequencyLabel.translatesAutoresizingMaskIntoConstraints = false
          cardView.addSubview(frequencyLabel)
          
          // Create and add the eye selection label
          let eyeSelectionLabel = UILabel()
          let selectedEyes = getSelectedEyes(prescription.eyeSelection)
          eyeSelectionLabel.text = "Eye Selection: \(selectedEyes)"
          eyeSelectionLabel.font = UIFont.systemFont(ofSize: 14)
          eyeSelectionLabel.textColor = .black
          eyeSelectionLabel.translatesAutoresizingMaskIntoConstraints = false
          cardView.addSubview(eyeSelectionLabel)
          
          // Create and add the cap color label
          let capColorLabel = UILabel()
          capColorLabel.text = "Cap Color: \(prescription.capColor)"
          capColorLabel.font = UIFont.systemFont(ofSize: 14)
          capColorLabel.textColor = .black
          capColorLabel.translatesAutoresizingMaskIntoConstraints = false
          cardView.addSubview(capColorLabel)
          
          // Create and add the special instruction label
          let specialInstructionLabel = UILabel()
          specialInstructionLabel.text = "Special Instructions: \(prescription.specialInstruction)"
          specialInstructionLabel.font = UIFont.systemFont(ofSize: 14)
          specialInstructionLabel.textColor = .black
          specialInstructionLabel.translatesAutoresizingMaskIntoConstraints = false
          cardView.addSubview(specialInstructionLabel)
          
          // Add constraints to the labels inside the card view
          NSLayoutConstraint.activate([
              medicineNameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
              medicineNameLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
              
              frequencyLabel.topAnchor.constraint(equalTo: medicineNameLabel.bottomAnchor, constant: 10),
              frequencyLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
              
              eyeSelectionLabel.topAnchor.constraint(equalTo: frequencyLabel.bottomAnchor, constant: 10),
              eyeSelectionLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
              
              capColorLabel.topAnchor.constraint(equalTo: eyeSelectionLabel.bottomAnchor, constant: 10),
              capColorLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
              
              specialInstructionLabel.topAnchor.constraint(equalTo: capColorLabel.bottomAnchor, constant: 10),
              specialInstructionLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
          ])
      }
      
      // Helper function to format eye selection into a readable string
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
    
    @objc func didTapInfo() {
        print("Info button tapped")
    }
    @objc func didTapMenu() {
        print("Menu button tapped")
    }
    
//    func handleNewPrescriptions(_ prescriptions: [Prescription]) {
//        viewModel.prescriptions = prescriptions
//    }
    
}
