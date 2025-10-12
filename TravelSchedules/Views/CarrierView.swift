//
//  CarrierView.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 12.10.2025.
//

import SwiftUI

struct CarrierView: View {
    var body: some View {
        // TODO: Will be implemented in next sprints
        NavigationStack {
            ZStack {
                Color.yWhite
                    .ignoresSafeArea()
                
                Text("Экран информации о перевозчике")
                    .font(.title)
                    .padding()
            }
        }
    }
}

#Preview {
    CarrierView()
}
