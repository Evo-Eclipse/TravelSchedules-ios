//
//  CarrierView.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 12.10.2025.
//

import SwiftUI

struct CarrierView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        // TODO: Will be implemented in next sprints
        ZStack {
            Color.yWhite
                .ignoresSafeArea()
            
            Text("Экран информации о перевозчике")
                .font(.title)
                .padding()
        }
        .customBackButton(dismiss: dismiss)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    CarrierView()
}
