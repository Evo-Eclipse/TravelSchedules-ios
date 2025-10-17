//
//  StoriesView.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 17.10.2025.
//

import SwiftUI

struct StoriesView: View {
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Configuration
    
    private let stories: [Story]
    private let secondsPerStory: TimeInterval = 5.0
    private let timerInterval: TimeInterval = 0.02
    
    // MARK: - State
    
    @State private var progress: CGFloat
    @State private var timer: Timer?
    
    // MARK: - Computed Properties
    
    private var progressPerTick: CGFloat {
        1.0 / CGFloat(stories.count) / secondsPerStory * timerInterval
    }
    
    private var currentStoryIndex: Int {
        min(Int(progress * CGFloat(stories.count)), stories.count - 1)
    }
    
    private var currentStory: Story {
        stories[currentStoryIndex]
    }
    
    private var progressPerStory: CGFloat {
        1.0 / CGFloat(stories.count)
    }
    
    // MARK: - Initialization
    
    init(stories: [Story], startIndex: Int = 0) {
        self.stories = stories
        let initialProgress = CGFloat(startIndex) / CGFloat(stories.count)
        _progress = State(initialValue: initialProgress)
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.yBlackUniversal.ignoresSafeArea()
            
            ZStack {
                currentStory.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .transition(.opacity)
                    .id(currentStoryIndex)
                
                VStack(spacing: 0) {
                    statusBar
                    closeButton
                    Spacer()
                    storyContent
                }
            }
            .padding(.top, 8)
            .padding(.bottom)
            
            tapAreas
        }
        .onAppear(perform: startTimer)
        .onDisappear(perform: stopTimer)
        .statusBarHidden()
    }
    
    // MARK: - Components
    
    private var statusBar: some View {
        HStack(spacing: 0) {
            ProgressBarView(
                numberOfSections: stories.count,
                progress: progress
            )
            .frame(height: 6)
            .padding(.horizontal, 12)
        }
        .padding(.top, 28)
        .padding(.bottom)
    }
    
    private var closeButton: some View {
        HStack {
            Spacer()
            Button {
                markCurrentAsViewed()
                dismiss()
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.yBlackUniversal)
                        .frame(width: 30, height: 30)
                    
                    Image(systemName: "xmark")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.yWhiteUniversal)
                }
            }
        }
        .padding(.horizontal, 12)
    }

    
    private var storyContent: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(currentStory.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.yWhiteUniversal)
            
            Text(currentStory.description)
                .font(.title3)
                .foregroundColor(.yWhiteUniversal)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 40)
    }
    
    private var tapAreas: some View {
        HStack(spacing: 0) {
            // Left tap area - previous story
            Rectangle()
                .fill(Color.clear)
                .contentShape(Rectangle())
                .onTapGesture {
                    goToPreviousStory()
                }
                .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity, pressing: { pressing in
                    if pressing {
                        stopTimer()
                    } else {
                        startTimer()
                    }
                }, perform: {})
            
            // Right tap area - next story
            Rectangle()
                .fill(Color.clear)
                .contentShape(Rectangle())
                .onTapGesture {
                    goToNextStory()
                }
                .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity, pressing: { pressing in
                    if pressing {
                        stopTimer()
                    } else {
                        startTimer()
                    }
                }, perform: {})
        }
        .padding(.top, 88)
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width < -50 {
                        goToNextStory()
                    } else if value.translation.width > 50 {
                        goToPreviousStory()
                    }
                }
        )
    }
    
    // MARK: - Timer Management
    
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { _ in
            advanceProgress()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: - Progress Management
    
    private func advanceProgress() {
        let newProgress = progress + progressPerTick
        
        if newProgress >= 1.0 {
            markCurrentAsViewed()
            stopTimer()
            dismiss()
        } else {
            progress = newProgress
        }
    }
    
    private func goToNextStory() {
        stopTimer()
        markCurrentAsViewed()
        
        let nextProgress = CGFloat(currentStoryIndex + 1) * progressPerStory
        withAnimation(.easeInOut(duration: 0.3)) {
            progress = nextProgress
        }
        startTimer()
    }
    
    private func goToPreviousStory() {
        stopTimer()
        
        if currentStoryIndex > 0 {
            withAnimation(.easeInOut(duration: 0.3)) {
                progress = CGFloat(currentStoryIndex - 1) * progressPerStory
            }
        } else {
            // If at first story, restart it
            withAnimation(.easeInOut(duration: 0.3)) {
                progress = 0
            }
        }
        
        startTimer()
    }
    
    private func markCurrentAsViewed() {
        StoriesStorage.shared.markAsViewed(currentStory.id)
    }
}

#Preview {
    StoriesView(stories: Story.samples, startIndex: 0)
}
