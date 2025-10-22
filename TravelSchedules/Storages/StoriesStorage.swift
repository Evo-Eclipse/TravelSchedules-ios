//
//  StoriesStorage.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 17.10.2025.
//

import Foundation

@MainActor
final class StoriesStorage: @unchecked Sendable {
    static let shared = StoriesStorage()
    private let key = "viewedStories"
    
    private init() {}
    
    var viewedStories: Set<UUID> {
        get {
            guard let data = UserDefaults.standard.data(forKey: key),
                  let strings = try? JSONDecoder().decode([String].self, from: data) else {
                return []
            }
            return Set(strings.compactMap { UUID(uuidString: $0) }) // QUESTION: Почему compactMap, а не map?
        }
        set {
            let strings = newValue.map { $0.uuidString }
            if let data = try? JSONEncoder().encode(strings) {
                UserDefaults.standard.set(data, forKey: key)
            }
        }
    }
    
    func markAsViewed(_ storyID: UUID) {
        var viewed = viewedStories
        viewed.insert(storyID)
        viewedStories = viewed
    }
    
    func isViewed(_ storyID: UUID) -> Bool {
        viewedStories.contains(storyID)
    }
}
