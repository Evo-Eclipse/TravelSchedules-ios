//
//  ToggleView.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 17.10.2025.
//

import SwiftUI

struct ToggleView: View {
    @Binding var isOn: Bool
    
    private let toggleWidth: CGFloat = 51
    private let toggleHeight: CGFloat = 31
    private let circleSize: CGFloat = 27
    private let circleOffset: CGFloat = 2
    
    var body: some View {
        ZStack(alignment: isOn ? .trailing : .leading) {
            RoundedRectangle(cornerRadius: toggleHeight / 2)
                .fill(isOn ? Color.yBlue : Color(red: 120/255, green: 120/255, blue: 128/255, opacity: 0.16))
                .frame(width: toggleWidth, height: toggleHeight)
            
            Circle()
                .fill(Color.yWhite)
                .frame(width: circleSize, height: circleSize)
                .padding(.horizontal, circleOffset)
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.25)) {
                isOn.toggle()
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var isOn: Bool = false
        
        var body: some View {
            ToggleView(isOn: $isOn)
        }
    }

    return PreviewWrapper()
}
