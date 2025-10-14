//
//  ListCellView.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 12.10.2025.
//

import SwiftUI

struct ListCellView: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.yBlack)
            Spacer()
            Image(systemName: "chevron.right")
                .fontWeight(.semibold)
                .foregroundColor(.yBlack)
        }
        .padding()
    }
}

#Preview {
    ListCellView(title: "Москва")
}
