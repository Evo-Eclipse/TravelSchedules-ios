//
//  Story.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 17.10.2025.
//

import SwiftUI

// MARK: - Story Model

struct Story: Identifiable {
    let id = UUID()
    let image: Image
    let title: String
    let description: String
}

// MARK: - Sample Data

extension Story {
    static let story1 = Story(
        image: Image(._01),
        title: "Рождение профессии",
        description: "Профессия проводника появилась в Англии в XIX веке для контроля безопасности"
    )
    
    static let story2 = Story(
        image: Image(._02),
        title: "Строители будущего",
        description: "Строительство первой ж/д в США длилось 7 лет с участием более 20000 рабочих"
    )
    
    static let story3 = Story(
        image: Image(._03),
        title: "Женщины на рельсах",
        description: "Первые женщины-проводницы появились в 1916 году на английских железных дорогах"
    )
    
    static let story4 = Story(
        image: Image(._04),
        title: "Рекорд скорости",
        description: "Самый быстрый поезд в мире — японский Синкансэн развивает скорость 320 км/ч"
    )
    
    static let story5 = Story(
        image: Image(._05),
        title: "Вместимость вагонов",
        description: "Пассажирский поезд вмещает 500-1200 человек — это 8-10 автобусов в одном составе"
    )
    
    static let story6 = Story(
        image: Image(._06),
        title: "Эпоха комфорта",
        description: "В 1930-1950х годах вагоны украшали редким деревом — ехать было одной роскошью"
    )
    
    static let story7 = Story(
        image: Image(._07),
        title: "Грузовая мощь",
        description: "Один поезд перевозит груз 50 грузовиков и при этом расходует меньше топлива"
    )
    
    static let story8 = Story(
        image: Image(._08),
        title: "Литература и рельсы",
        description: "Поезда вдохновляли писателей: Толстой, Джеймс и Верн писали о ж/д путешествиях"
    )
    
    static let story9 = Story(
        image: Image(._09),
        title: "На вершине мира",
        description: "Некоторые горные ж/д работают на высоте более 4000 метров над уровнем моря"
    )
    
    static let story10 = Story(
        image: Image(._10),
        title: "Эра паровозов",
        description: "Паровозы доминировали в транспорте до 1960х, развивая скорость до 160 км/ч"
    )
    
    static let story11 = Story(
        image: Image(._11),
        title: "Индийская сеть",
        description: "Индийские локальные поезда перевозят 1 млрд. пассажиров в год — крупнейшая сеть"
    )
    
    static let story12 = Story(
        image: Image(._12),
        title: "Первый вокзал",
        description: "Первый железнодорожный вокзал открылся в Манчестере в 1830 году в Англии"
    )
    
    static let story13 = Story(
        image: Image(._13),
        title: "Революция в сельском хозяйстве",
        description: "Грузовые поезда снизили стоимость доставки урожая фермеров на 60-70% в XIX веке"
    )
    
    static let story14 = Story(
        image: Image(._14),
        title: "Холодильные вагоны",
        description: "Холодильные вагоны революционизировали продовольственный рынок с конца XIX века"
    )
    
    static let story15 = Story(
        image: Image(._15),
        title: "Вагонные концерты",
        description: "В XIX веке музыканты развлекали пассажиров в вагонах, путешествуя по Европе"
    )
    
    static let story16 = Story(
        image: Image(._16),
        title: "Гармонь и романтика",
        description: "Гармонь связана с европейским железнодорожным романтизмом XX века в культуре"
    )
    
    static let story17 = Story(
        image: Image(._17),
        title: "Вдохновение движения",
        description: "Писатели считали ритм поезда идеальным условием для творчества и вдохновения"
    )
    
    static let story18 = Story(
        image: Image(._18),
        title: "Эффективность ночи",
        description: "Ночные поезда — самый экономичный транспорт для дальних маршрутов в Европе"
    )
    
    static let samples: [Story] = [
        .story1, .story2, .story3, .story4, .story5, .story6, .story7, .story8, .story9,
        .story10, .story11, .story12, .story13, .story14, .story15, .story16, .story17, .story18
    ]
}
