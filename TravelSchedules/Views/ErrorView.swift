//
//  ErrorView.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 12.10.2025.
//

import SwiftUI

struct ErrorView: View {
    let type: ErrorViewType
    
    var body: some View {
        ZStack {
            Color.yWhite
                .ignoresSafeArea()
            
            VStack {
                Image(type == .noInternet ? .imageNoInternet : .imageServerError)
                    .ignoresSafeArea()
                Text(type == .noInternet ? "Нет интернета" : "Ошибка сервера")
                    .font(.title)
                    .bold()
                    .foregroundColor(.yBlack)
            }
        }
    }
}

enum ErrorViewType {
    case noInternet
    case serverError
}

#Preview {
    ErrorView(type: .noInternet)
}
