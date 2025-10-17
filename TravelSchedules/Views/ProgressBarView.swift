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
            ZStack(alignment: .leading) {
                backgroundBar(width: geometry.size.width)
                progressBar(width: geometry.size.width)
            }
            .mask {
                ProgressMaskView(
                    numberOfSections: numberOfSections,
                    cornerRadius: cornerRadius,
                    height: height,
                    spacing: sectionSpacing
                )
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Story progress")
            .accessibilityValue("\(Int(progress * 100))%")
        }
    }
        
    private func backgroundBar(width: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .frame(width: width, height: height)
            .foregroundStyle(.yWhiteUniversal)
    }
    
    private func progressBar(width: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .frame(
                width: min(progress * width, width),
                height: height
            )
            .foregroundStyle(.yBlue)
    }
}

private struct ProgressMaskView: View {
    let numberOfSections: Int
    let cornerRadius: CGFloat
    let height: CGFloat
    let spacing: CGFloat
    
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<numberOfSections, id: \.self) { _ in
                MaskSectionView(
                    cornerRadius: cornerRadius,
                    height: height
                )
            }
        }
    }
}

private struct MaskSectionView: View {
    let cornerRadius: CGFloat
    let height: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .frame(height: height)
            .foregroundStyle(.white)
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
