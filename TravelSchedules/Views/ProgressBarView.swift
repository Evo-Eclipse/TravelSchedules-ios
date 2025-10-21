//
//  ProgressBarView.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 17.10.2025.
//

import SwiftUI

struct ProgressBarView: View {
    let numberOfSections: Int
    let progress: CGFloat
    
    private let sectionSpacing: CGFloat = 2
    private let cornerRadius: CGFloat = 6
    private let height: CGFloat = 6
    
    var body: some View {
        GeometryReader { geometry in
            ProgressShape(
                numberOfSections: numberOfSections,
                progress: progress,
                spacing: sectionSpacing,
                cornerRadius: cornerRadius
            )
            .fill(.yBlue)
            .background {
                ProgressShape(
                    numberOfSections: numberOfSections,
                    progress: 1.0,
                    spacing: sectionSpacing,
                    cornerRadius: cornerRadius
                )
                .fill(.yWhiteUniversal)
            }
            .frame(height: height)
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Story progress")
            .accessibilityValue("\(Int(progress * 100))%")
        }
    }
}

private struct ProgressShape: Shape {
    let numberOfSections: Int
    let progress: CGFloat
    let spacing: CGFloat
    let cornerRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let sectionWidth = (rect.width - spacing * CGFloat(numberOfSections - 1)) / CGFloat(numberOfSections)
        let progressWidth = rect.width * progress
        
        for index in 0..<numberOfSections {
            let xPosition = CGFloat(index) * (sectionWidth + spacing)
            let sectionRect = CGRect(
                x: xPosition,
                y: 0,
                width: min(sectionWidth, max(0, progressWidth - xPosition)),
                height: rect.height
            )
            
            if sectionRect.width > 0 {
                path.addRoundedRect(
                    in: sectionRect,
                    cornerSize: CGSize(width: cornerRadius, height: cornerRadius)
                )
            }
        }
        
        return path
    }
}

#Preview {
    VStack(spacing: 20) {
        ProgressBarView(numberOfSections: 3, progress: 0.5)
            .frame(height: 6)
            .padding()
        
        ProgressBarView(numberOfSections: 5, progress: 0.7)
            .frame(height: 6)
            .padding()
        
        ProgressBarView(numberOfSections: 3, progress: 1.0)
            .frame(height: 6)
            .padding()
    }
}
