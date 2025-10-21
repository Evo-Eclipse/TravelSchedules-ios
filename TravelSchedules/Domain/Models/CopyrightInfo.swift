//
//  CopyrightInfo.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 07.10.2025.
//
//  Components.Schemas.ResponseCopyright
//

import Foundation

struct CopyrightInfo: Equatable, Hashable {
    let url: URL
    let text: String
    let logos: [URL]
}
