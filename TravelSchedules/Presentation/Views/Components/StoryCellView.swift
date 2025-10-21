//
//  StoryCell.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 21.10.2025.
//

import SwiftUI

struct StoryCellView: View {
    let story: Story
    let refreshTrigger: UUID
    let action: () -> Void
    @State private var isViewed: Bool = false
    
    var body: some View {
        Button(action: action) {
            ZStack(alignment: .bottomLeading) {
                story.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 92, height: 140)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .opacity(isViewed ? 0.5 : 1.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .strokeBorder(Color.yBlue, lineWidth: isViewed ? 0 : 4)
                    )
                
                Text(story.title)
                    .font(.caption)
                    .foregroundColor(.yWhiteUniversal)
                    .lineLimit(2)
                    .padding(8)
            }
        }
        .buttonStyle(.plain)
        .frame(width: 92, height: 140)
        .onAppear {
            isViewed = StoriesStorage.shared.isViewed(story.id)
        }
        .onChange(of: refreshTrigger) { _, _ in
            isViewed = StoriesStorage.shared.isViewed(story.id)
        }
    }
}

#Preview {
    StoryCellView(
        story: Story(
            id: UUID(),
            image: Image(._02),
            title: "Story example",
            description: "Story example"
        ),
        refreshTrigger: UUID(),
        action: {}
    )
    .padding()
}
