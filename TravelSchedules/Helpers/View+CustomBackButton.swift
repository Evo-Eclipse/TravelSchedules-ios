//
//  View+CustomBackButton.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 14.10.2025.
//

import SwiftUI

extension View {
    func customBackButton(dismiss: DismissAction) -> some View {
        self.toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .fontWeight(.semibold)
                        .foregroundColor(.yBlack)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
