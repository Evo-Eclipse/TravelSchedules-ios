//
//  ScheduleCardView.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 13.10.2025.
//

import SwiftUI

struct ScheduleCardView: View {
    let segment: TripSegment
    
    private func formatTime(_ timeString: String?) -> String {
        guard let timeString = timeString else { return "--:--" }
        
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
                        .cornerRadius(12)
                    } else {
                        Rectangle()
                            .fill(Color.yGrayLight)
                            .frame(width: 38, height: 38)
                            .cornerRadius(12)
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
                    Text(DateParsing.displayDateFormatter.string(from: date))
                        .font(.caption)
                        .foregroundColor(.yBlackUniversal)
                }
            }
            
            HStack(alignment: .center, spacing: 0) {
                Text(formatTime(segment.departureTime))
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
                        .font(.caption)
                        .foregroundColor(.yBlackUniversal)
                        .fixedSize()
                } else {
                    Text("--")
                        .font(.caption)
                        .foregroundColor(.yBlackUniversal)
                        .fixedSize()
                }
                
                Rectangle()
                    .fill(Color.yGrayUniversal)
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 4)
                
                Text(formatTime(segment.arrivalTime))
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
        code: "s2006004",
        title: "Москва (Ленинградский вокзал)",
        cityCode: "c213",
        lat: nil, lng: nil,
        transportType: .train,
        stationType: .station,
        stationTypeName: nil,
        esrCode: nil,
        direction: nil,
        majority: nil,
        distanceKm: nil
    )
    
    let toStation = Station(
        code: "s9602494",
        title: "Санкт-Петербург (Московский вокзал)",
        cityCode: "c2",
        lat: nil, lng: nil,
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
        contacts: "Единая телефонная линия: +7 (800) 775-00-00",
        address: "Москва, ул. Новая Басманная, д. 2",
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
        days: "13 января, 7, 10, 14, 17, 21, 25, 28 февраля",
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
