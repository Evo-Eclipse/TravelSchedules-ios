//
//  Story.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 17.10.2025.
//

import SwiftUI

// MARK: - Story Model

struct Story: Identifiable {
    let id: UUID
    let image: Image
    let title: String
    let description: String
}

// MARK: - Sample Data

extension Story {
    static let story1 = Story(
        id: UUID(uuidString: "4C75A67A-C97F-4A7C-970B-B26A1B09B8E1")!,
        image: Image(._01),
        title: "Рождение профессии",
        description: "Профессия проводника появилась в Англии в XIX веке для контроля безопасности"
    )
    
    static let story2 = Story(
        id: UUID(uuidString: "D9C7AE4B-7E7E-4C61-AA8E-0C1E3D5D7F01")!,
        image: Image(._02),
        title: "Строители будущего",
        description: "Строительство первой ж/д в США длилось 7 лет с участием более 20000 рабочих"
    )
    
    static let story3 = Story(
        id: UUID(uuidString: "8F1B2E7C-94A2-4F6B-9C4A-1F2A3B4C5D6E")!,
        image: Image(._03),
        title: "Женщины на рельсах",
        description: "Первые женщины-проводницы появились в 1916 году на английских железных дорогах"
    )
    
    static let story4 = Story(
        id: UUID(uuidString: "2A6F8B9C-1D3E-4F5A-9B8C-7D6E5F4A3B2C")!,
        image: Image(._04),
        title: "Рекорд скорости",
        description: "Самый быстрый поезд в мире — японский Синкансэн развивает скорость 320 км/ч"
    )
    
    static let story5 = Story(
        id: UUID(uuidString: "7B3E9C2A-5D1F-4A6B-8C9D-0E1F2A3B4C5D")!,
        image: Image(._05),
        title: "Вместимость вагонов",
        description: "Пассажирский поезд вмещает 500-1200 человек — это 8-10 автобусов в одном составе"
    )
    
    static let story6 = Story(
        id: UUID(uuidString: "1C2D3E4F-5A6B-7C8D-9E0F-A1B2C3D4E5F6")!,
        image: Image(._06),
        title: "Эпоха комфорта",
        description: "В 1930-1950х годах вагоны украшали редким деревом — ехать было одной роскошью"
    )
    
    static let story7 = Story(
        id: UUID(uuidString: "E3D2C1B0-A9F8-E7D6-C5B4-A3F2E1D0C9B8")!,
        image: Image(._07),
        title: "Грузовая мощь",
        description: "Один поезд перевозит груз 50 грузовиков и при этом расходует меньше топлива"
    )
    
    static let story8 = Story(
        id: UUID(uuidString: "9A8B7C6D-5E4F-3A2B-1C0D-EF1A2B3C4D5E")!,
        image: Image(._08),
        title: "Литература и рельсы",
        description: "Поезда вдохновляли писателей: Толстой, Джеймс и Верн писали о ж/д путешествиях"
    )
    
    static let story9 = Story(
        id: UUID(uuidString: "5F4E3D2C-1B0A-9F8E-7D6C-5B4A3F2E1D0C")!,
        image: Image(._09),
        title: "На вершине мира",
        description: "Некоторые горные ж/д работают на высоте более 4000 метров над уровнем моря"
    )
    
    static let story10 = Story(
        id: UUID(uuidString: "0A1B2C3D-4E5F-6071-8293-A4B5C6D7E8F9")!,
        image: Image(._10),
        title: "Эра паровозов",
        description: "Паровозы доминировали в транспорте до 1960х, развивая скорость до 160 км/ч"
    )
    
    static let story11 = Story(
        id: UUID(uuidString: "A1B2C3D4-E5F6-7081-92A3-B4C5D6E7F809")!,
        image: Image(._11),
        title: "Индийская сеть",
        description: "Индийские локальные поезда перевозят 1 млрд. пассажиров в год — крупнейшая сеть"
    )
    
    static let story12 = Story(
        id: UUID(uuidString: "B0C1D2E3-F4A5-6B70-8192-A3B4C5D6E7F8")!,
        image: Image(._12),
        title: "Первый вокзал",
        description: "Первый железнодорожный вокзал открылся в Манчестере в 1830 году в Англии"
    )
    
    static let story13 = Story(
        id: UUID(uuidString: "C9D8E7F6-A5B4-C3D2-E1F0-9A8B7C6D5E4F")!,
        image: Image(._13),
        title: "Революция в сельском хозяйстве",
        description: "Грузовые поезда снизили стоимость доставки урожая фермеров на 60-70% в XIX веке"
    )
    
    static let story14 = Story(
        id: UUID(uuidString: "D8C7B6A5-4E3F-2A1B-0C9D-8E7F6A5B4C3D")!,
        image: Image(._14),
        title: "Холодильные вагоны",
        description: "Холодильные вагоны революционизировали продовольственный рынок с конца XIX века"
    )
    
    static let story15 = Story(
        id: UUID(uuidString: "E7F6A5B4-C3D2-E1F0-9A8B-7C6D5E4F3A2B")!,
        image: Image(._15),
        title: "Вагонные концерты",
        description: "В XIX веке музыканты развлекали пассажиров в вагонах, путешествуя по Европе"
    )
    
    static let story16 = Story(
        id: UUID(uuidString: "F6E5D4C3-B2A1-09F8-E7D6-C5B4A3F2E1D0")!,
        image: Image(._16),
        title: "Гармонь и романтика",
        description: "Гармонь связана с европейским железнодорожным романтизмом XX века в культуре"
    )
    
    static let story17 = Story(
        id: UUID(uuidString: "ABCDEF12-3456-7890-ABCD-EF1234567890")!,
        image: Image(._17),
        title: "Вдохновение движения",
        description: "Писатели считали ритм поезда идеальным условием для творчества и вдохновения"
    )
    
    static let story18 = Story(
        id: UUID(uuidString: "12345678-90AB-CDEF-1234-567890ABCDEF")!,
        image: Image(._18),
        title: "Эффективность ночи",
        description: "Ночные поезда — самый экономичный транспорт для дальних маршрутов в Европе"
    )
    
    static let samples: [Story] = [
        .story1, .story2, .story3, .story4, .story5, .story6, .story7, .story8, .story9,
        .story10, .story11, .story12, .story13, .story14, .story15, .story16, .story17, .story18
    ]
}
