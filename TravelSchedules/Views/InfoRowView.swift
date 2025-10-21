//
//  InfoRow.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 21.10.2025.
//

import SwiftUI

struct InfoRowView: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(label)
                .foregroundColor(.yBlack)
            
            Text(value)
                .font(.caption)
                .foregroundColor(.yBlue)
        }
        .padding(.vertical, 12)
    }
}

#Preview {
    InfoRowView(label: "Example Label", value: "Example Value")
        .padding()
}
