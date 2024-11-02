//
//  LocationView.swift
//  Places
//
//  Created by Andrei Marcu on 01.11.2024.
//

import SwiftUI

struct LocationView<VM: LocationViewModelProtocol>: View {
    @StateObject var viewModel: VM
    
    var body: some View {
        Button {
            viewModel.didTapView()
        } label: {
            VStack(alignment: .leading, spacing: 0) {
                Text(viewModel.name)
                    .font(.title)
                    .foregroundColor(.primary)
                    .padding(.bottom, 18)
                Text(viewModel.latitude)
                    .font(.body)
                    .padding(.bottom, 8)
                Text(viewModel.longitude)
                    .font(.body)
            }
        }
        .accessibilityLabel("Location details")
        .accessibilityHint("Open the location in Wikipedia app")
    }
}

#Preview {
    let locations = [
        Location(
            name: "Amsterdam",
            lat: 52.3547498,
            lon: 4.8339215),
        Location(
            name: nil,
            lat: 52.3547498,
            lon: 4.8339215)
    ]
    
    return List(locations) { item in
        LocationView(
            viewModel: LocationViewModel(
                location: item,
                onViewTapped: { print("Tapped id = \($0)") }))
    }
}
