//
//  ScheduleSegmentCardView.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 13.10.2025.
//

import SwiftUI

struct ScheduleCardView: View {
    let segment: TripSegment
    
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM"
        return formatter
    }()
    
    // Parse time string like "22:30:00" or "22:30" to "22:30"
    private func formatTime(_ timeString: String?) -> String {
        guard let timeString = timeString else { return "--:--" }
        
        // Try to extract HH:mm from various formats
        let components = timeString.split(separator: ":")
        if components.count >= 2 {
            return "\(components[0]):\(components[1])"
        }
        
        return timeString
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                if let carrier = segment.thread?.carrier {
                    if let logoURL = carrier.logoURL {
                        AsyncImage(url: logoURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 38, height: 38)
                    } else {
                        Rectangle()
                            .fill(Color.yGrayLight)
                            .frame(width: 38, height: 38)
                    }
                } else {
                    Rectangle()
                        .fill(Color.yGrayLight)
                        .frame(width: 38, height: 38)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(segment.thread?.carrier?.title ?? "")
                        .foregroundColor(.yBlackUniversal)
                    
                    if let title = segment.thread?.title, title.contains("пересадк") {
                        Text(title)
                            .font(.caption)
                            .foregroundColor(.yRed)
                    }
                }
                
                Spacer()
                
                if let startDate = segment.startDate,
                   let date = DateParsing.parseDateString(startDate) {
                    Text(dateFormatter.string(from: date))
                        .font(.caption)
                        .foregroundColor(.yBlackUniversal)
                }
            }
            
            HStack(alignment: .center, spacing: 0) {
                Text(formatTime(segment.departureTime))
                    .font(.system(size: 24, weight: .regular))
                    .foregroundColor(.yBlackUniversal)
                    .fixedSize()
                
                Rectangle()
                    .fill(Color.yGrayUniversal)
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 4)
                
                if let durationSec = segment.durationSec {
                    let hours = durationSec / 3600
                    Text("\(hours) часов")
                        .font(.system(size: 12))
                        .foregroundColor(.yBlackUniversal)
                        .fixedSize()
                } else {
                    Text("--")
                        .font(.system(size: 12))
                        .foregroundColor(.yBlackUniversal)
                        .fixedSize()
                }
                
                Rectangle()
                    .fill(Color.yGrayUniversal)
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 4)
                
                Text(formatTime(segment.arrivalTime))
                    .font(.system(size: 24, weight: .regular))
                    .foregroundColor(.yBlackUniversal)
                    .fixedSize()
            }
        }
        .padding()
        .background(Color.yGrayLight)
        .cornerRadius(16)
    }
}

#Preview {
    let fromStation = Station(
        code: "s2006004", // Москва (Ленинградский вокзал)
        title: "Москва (Ленинградский вокзал)",
        cityCode: "c213", // Москва
        lat: nil,
        lng: nil,
        transportType: .train,
        stationType: .station,
        stationTypeName: nil,
        esrCode: nil,
        direction: nil,
        majority: nil,
        distanceKm: nil
    )
    
    let toStation = Station(
        code: "s9602494", // Санкт-Петербург (Московский вокзал)
        title: "Санкт-Петербург (Московский вокзал)",
        cityCode: "c2", // Санкт-Петербург
        lat: nil,
        lng: nil,
        transportType: .train,
        stationType: .station,
        stationTypeName: nil,
        esrCode: nil,
        direction: nil,
        majority: nil,
        distanceKm: nil
    )
    
    let carrier = Carrier(
        code: "112",
        title: "РЖД/ФПК",
        logoURL: URL(string: "https://yastat.net/s3/rasp/media/data/company/logo/logo.gif"),
        url: URL(string: "http://www.rzd.ru/"),
        phone: "+7 (800) 775-00-00",
        email: "info@rzd.ru",
        contacts: "Единая телефонная линия: +7 (800) 775-00-00 (звонок бесплатный из всех регионов РФ).",
        address: "Москва, ул. Новая Басманная , д. 2",
        codes: Carrier.Codes(icao: nil, iata: nil, sirena: nil)
    )
    
    let thread = ThreadSummary(
        uid: "154A_0_2",
        number: "154А",
        title: "Москва — Санкт-Петербург",
        carrier: carrier,
        transportType: .train,
        vehicle: nil,
        startTime: nil,
        days: "13 января, 7, 10, 14, 17, 21, 25, 28 февраля, 3, 7, 11, 14, 17, 21, 24, 28, 31 марта, 4, 7, 11 апреля, …",
        interval: nil
    )
    
    let segment = TripSegment(
        id: "154A_0_2",
        from: fromStation,
        to: toStation,
        departure: nil,
        arrival: nil,
        departureTime: "01:25:00",
        arrivalTime: "09:50:00",
        startDate: "2026-01-13",
        durationSec: 30300,
        thread: thread,
        tickets: nil
    )
    
    ScheduleCardView(segment: segment)
        .padding()
}
