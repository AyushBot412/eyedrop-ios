//
//  PrescriptionModel.swift
//  Eyedrop Recognition
//
//  Created by Elise Jang on 3/20/25.
//

import Foundation
import UIKit
import SwiftUI


class PrescriptionViewModel: ObservableObject {
    @Published var prescriptions: [Prescription] = []
}

struct Prescription: Codable, Identifiable {
    let id: Int
    let uniqueKey: String
    let medicineName: String
    let eyeSelection: EyeSelection
    let frequency: String
    let capColor: String
    let specialInstruction: String
}

struct EyeSelection: Codable {
    let left: Bool
    let right: Bool
    let both: Bool
}

struct PrescriptionListView: View {
    @ObservedObject var viewModel: PrescriptionViewModel
    
    var body: some View {
        NavigationView {
                    List(viewModel.prescriptions) { prescription in
                        NavigationLink(destination: PrescriptionDetailView(prescription: prescription)) {
                            VStack(alignment: .leading) {
                                Text(prescription.medicineName)
                                    .font(.headline)
                                Text("Frequency: \(prescription.frequency)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                        }
                    }
                    .navigationTitle("Prescriptions")
                }
            }
        }

struct PrescriptionDetailView: View {
    var prescription: Prescription

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(prescription.medicineName)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.black)
//            Text("Dosage: \(prescription.dosage)")
//                .font(.title2)
//            Text("Instructions: \(prescription.instructions)")
//                .font(.body)
            Spacer()
        }
        .padding()
        .navigationTitle("Details")
        .background(Color.white)
    }
}
