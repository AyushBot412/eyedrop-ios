//
//  InstructVC.swift
//  Eyedrop Recognition
//
//  Created by Elise Jang on 3/14/25.
//

import UIKit

class InstructVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var sampleprescriptions: [Prescription] = [
        Prescription(id: 1, uniqueKey: "e10d0d87-006a-48c5-bcfa-933365e42db3", medicineName: "Timolol", eyeSelection: EyeSelection(left: true, right: false, both: false), frequency: "1 time/Day", capColor: "Blue", specialInstruction: "N/A"),
        Prescription(id: 2, uniqueKey: "a74f3d8c-df12-4b1c-bd83-acc9e2bd130a", medicineName: "Latanoprost", eyeSelection: EyeSelection(left: false, right: true, both: false), frequency: "2 times/Day", capColor: "Green", specialInstruction: "Store in fridge"),
        Prescription(id: 3, uniqueKey: "b9cdd2fb-5f7e-4d10-9d65-4f9342046ad7", medicineName: "Brimonidine", eyeSelection: EyeSelection(left: false, right: false, both: true), frequency: "3 times/Day", capColor: "Purple", specialInstruction: "Wait 5 mins before next drop")
    ]
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Constants.initialize(frame: view.frame)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .white
        NotificationCenter.default.addObserver(self, selector: #selector(handlePrescriptionDeleted(_:)), name: Notification.Name("PrescriptionDeleted"), object: nil)
        // Setup the table view
        setupTableView()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupUI()
    }
    
    private func setupUI() {
        configureTopBar()
        
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
    
    func setupTableView() {
        // Initialize table view
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        
        // Register the custom cell
        tableView.register(PrescriptionCell.self, forCellReuseIdentifier: PrescriptionCell.identifier)
        
        // Add table view to the view
        view.addSubview(tableView)
        
        // Add constraints for the table view
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),  // Adjust for the top bar
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // TableView DataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleprescriptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PrescriptionCell.identifier, for: indexPath) as! PrescriptionCell
        let prescription = sampleprescriptions[indexPath.row]
        cell.configure(with: prescription)
        return cell
    }
    
    // TableView Delegate method to handle row selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPrescription = sampleprescriptions[indexPath.row]
        navigateToPrescriptionDetail(prescription: selectedPrescription)
    }
    
    // Method to navigate to the detail view
    func navigateToPrescriptionDetail(prescription: Prescription) {
        let detailVC = PrescriptionDetailVC()
        detailVC.prescription = prescription
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    @objc func didTapInfo() {
        let alert = UIAlertController(
                title: "Info",
                message: "These prescriptions are scanned in using the QR on your prescription provided by your doctor.",
                preferredStyle: .alert
            )

            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))

            present(alert, animated: true, completion: nil)
        }
    
    @objc func didTapMenu() {
        // Create the action sheet
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // Add "Add Medicines" option with a plus icon
        let addAction = UIAlertAction(title: "Add Medicines", style: .default, handler: { _ in
            self.addMedicines()
        })
        addAction.setValue(UIImage(systemName: "plus.circle.fill"), forKey: "image")
        
        // Add "Delete Medicines" option with a trash icon
        let deleteAction = UIAlertAction(title: "Delete Medicines", style: .destructive, handler: { _ in
            self.deleteMedicines()
        })
        deleteAction.setValue(UIImage(systemName: "trash.fill"), forKey: "image")
        
        // Add actions to the action sheet
        actionSheet.addAction(addAction)
        actionSheet.addAction(deleteAction)
        
        // Add Cancel option to dismiss the action sheet
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // Present the action sheet
        present(actionSheet, animated: true, completion: nil)
    }
    
    
    @objc private func handlePrescriptionDeleted(_ notification: Notification) {
        if let deletedPrescription = notification.object as? Prescription {
            //CHANGE SAMPLE PRESCRIPTION TO REG
            sampleprescriptions.removeAll { $0.id == deletedPrescription.id }
            tableView.reloadData()
        }
    }
    
    private func addMedicines() {
        print("Add Medicines tapped")
        // Add the logic for adding medicines
    }

    // Function to handle Delete Medicines action
    private func deleteMedicines() {
        print("Delete Medicines tapped")
        // Add the logic for deleting medicines
    }
    
}

class PrescriptionCell: UITableViewCell {
    static let identifier = "PrescriptionCell"
    
    private var iconView: UILabel!
    private var medicineNameLabel: UILabel!
    private var frequencyLabel: UILabel!
    private var arrowImageView: UIImageView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Left circular icon with the first letter
        iconView = UILabel()
        iconView.font = UIFont.boldSystemFont(ofSize: 20)
        iconView.textAlignment = .center
        iconView.textColor = .white
        iconView.backgroundColor = UIColor.systemBlue
        iconView.layer.cornerRadius = 30
        iconView.layer.masksToBounds = true
        iconView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(iconView)
        
        // Main title
        medicineNameLabel = UILabel()
        medicineNameLabel.font = UIFont.boldSystemFont(ofSize: 30)
        medicineNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(medicineNameLabel)
        
        // Subtitle
        frequencyLabel = UILabel()
        frequencyLabel.font = UIFont.systemFont(ofSize: 20)
        frequencyLabel.textColor = .darkGray
        frequencyLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(frequencyLabel)
        
        // Right arrow icon
        arrowImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        arrowImageView.tintColor = .gray
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(arrowImageView)
        
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 60),
            iconView.heightAnchor.constraint(equalToConstant: 60),
            
            medicineNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            medicineNameLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 15),
            medicineNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: arrowImageView.leadingAnchor, constant: -10),
            
            frequencyLabel.topAnchor.constraint(equalTo: medicineNameLabel.bottomAnchor, constant: 5),
            frequencyLabel.leadingAnchor.constraint(equalTo: medicineNameLabel.leadingAnchor),
            frequencyLabel.trailingAnchor.constraint(lessThanOrEqualTo: arrowImageView.leadingAnchor, constant: -10),
            frequencyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            arrowImageView.widthAnchor.constraint(equalToConstant: 10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Configure the cell with data
    func configure(with prescription: Prescription) {
        medicineNameLabel.text = prescription.medicineName
        frequencyLabel.text = "Frequency: \(prescription.frequency)"
        if let firstChar = prescription.medicineName.first {
            iconView.text = String(firstChar).uppercased()
        } else {
            iconView.text = "?"
        }
    }
}
