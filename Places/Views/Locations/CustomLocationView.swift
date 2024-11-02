//
//  CustomLocationView.swift
//  Places
//
//  Created by Andrei Marcu on 01.11.2024.
//

import SwiftUI

struct CustomLocationView<VM: CustomLocationViewModelProtocol>: View {
    @ObservedObject var viewModel: VM
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading, spacing: 5) {
                Text(viewModel.locationNameLabel)
                    .font(.caption)
                TextField(viewModel.locationNamePlaceholder, text: $viewModel.locationName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Location name text entry")
            VStack(alignment: .leading, spacing: 5) {
                Text(viewModel.latitudeLabel)
                    .font(.caption)
                TextField(viewModel.latitudePlaceholder, text: $viewModel.latitude)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Latitude text entry")
            VStack(alignment: .leading, spacing: 5) {
                Text(viewModel.longitudeLabel)
                    .font(.caption)
                TextField(viewModel.longitudePlaceholder, text: $viewModel.longitude)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Longitude text entry")
            HStack(alignment: .top) {
                Spacer()
                Button("Continue") {
                    if viewModel.tappedContinue() {
                        dismiss()
                    }
                }
                .accessibilityLabel("Continue with selected location")
                .accessibilityHint("Uses the inputed latitude and longitude to display it in Wikipedia App")
                Spacer()
            }
        }
        .padding(.horizontal)
        .alert(viewModel.alertMessage, isPresented: $viewModel.showingAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

#Preview {
    CustomLocationView(viewModel: CustomLocationViewModel())
}
