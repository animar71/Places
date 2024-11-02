//
//  ContentView.swift
//  Places
//
//  Created by Andrei Marcu on 30.10.2024.
//

import SwiftUI

struct LocationsView<VM: LocationsViewModelProtocol>: View {
    @StateObject var viewModel: VM
    @State private var showingCustomLocationSheet = false
    
    var body: some View {
        ZStack {
            VStack {
                Button("Set custom location") {
                    showingCustomLocationSheet.toggle()
                }
                .accessibilityHint("Open a bottom sheet to set a custom location")
                locationsList
                    .accessibilityLabel("A list of locations")
                    .accessibilityHint("A tappable list of locations that will be displayed in Wikipedia app")
                Spacer()
            }
            loadingIndicator
        }
        .sheet(isPresented: $showingCustomLocationSheet) {
            CustomLocationView(viewModel: CustomLocationViewModel())
        }
        .alert(viewModel.alertMessage, isPresented: $viewModel.showingAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

// MARK: - Private API
private extension LocationsView {
    @ViewBuilder
    var locationsList: some View {
        if !viewModel.locations.isEmpty {
            List(viewModel.locations) { item in
                LocationView(
                    viewModel: LocationViewModel(
                        location: item,
                        onViewTapped: {
                            viewModel.didTapLocation(id: $0)
                        }))
            }
        }
    }
    
    @ViewBuilder
    var loadingIndicator: some View {
        if viewModel.isLoading {
            ProgressView("Loading")
        }
    }
}

#Preview {
    LocationsView(
        viewModel: MockedLocationsViewModel())
}
