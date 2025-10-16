//
//  CarrierView.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 12.10.2025.
//

import SwiftUI

struct CarrierInfoView: View {
    @Environment(\.dismiss) private var dismiss
    let carrier: Carrier
    
    var body: some View {
        ZStack {
            Color.yWhite.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                logoPlaceholder
                carrierTitle
                contactInfo
                Spacer()
            }
        }
        .navigationTitle("Информация о перевозчике")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .customBackButton(dismiss: dismiss)
    }
    
    // MARK: - Components
    
    @ViewBuilder
    private var logoPlaceholder: some View {
        if let logoURL = carrier.logoURL {
            AsyncImage(url: logoURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(height: 104)
            .cornerRadius(24)
            .padding()
        } else {
            Rectangle()
                .fill(.yGrayLight)
                .frame(height: 104)
                .cornerRadius(24)
                .padding()
        }
    }
    
    private var carrierTitle: some View {
        Text(carrier.title ?? "Неизвестный перевозчик")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.yBlack)
            .padding(.horizontal)
    }
    
    private var contactInfo: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(infoFields, id: \.label) { field in
                InfoRow(label: field.label, value: field.value)
            }
        }
        .padding()
    }
    
    private var infoFields: [(label: String, value: String)] {
        [
            carrier.email.map { ("E-mail", $0) },
            carrier.phone.map { ("Телефон", $0) },
            // carrier.url.map { ("Сайт", $0.absoluteString) },
            // carrier.address.map { ("Адрес", $0) },
            // carrier.contacts.map { ("Контакты", $0) }
        ].compactMap { $0 }
    }
}

struct InfoRow: View {
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
    NavigationStack {
        CarrierInfoView(
            carrier: Carrier(
                code: "su",
                title: "ОАО «РЖД»",
                logoURL: URL(string: "https://yastat.net/s3/rasp/media/data/company/logo/logo.gif"),
                url: URL(string: "https://www.rzd.ru"),
                phone: "+7 (800) 775-00-00",
                email: "info@rzd.ru",
                contacts: "Круглосуточная горячая линия",
                address: "107174, г. Москва, ул. Новая Басманная, д. 2",
                codes: Carrier.Codes(
                    icao: nil,
                    iata: nil,
                    sirena: nil
                )
            )
        )
    }
}
