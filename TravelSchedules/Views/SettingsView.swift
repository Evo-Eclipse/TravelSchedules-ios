//
//  SettingsView.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 12.10.2025.
//

import SwiftUI

struct SettingsView: View {
    @Environment(ThemeManager.self) private var themeManager
    @State private var showUserAgreement = false
    
    var body: some View {
        ZStack {
            Color.yWhite.ignoresSafeArea()
            
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    darkModeToggle
                    userAgreementLink
                }
                .padding(.top, 24)
                
                Spacer()
                
                footerInfo
                    .padding(.bottom, 24)
            }
            .padding(.horizontal, 16)
        }
        .fullScreenCover(isPresented: $showUserAgreement) {
            NavigationStack {
                UserAgreementView(url: URL(string: "https://yandex.ru/legal/rasp/?lang=ru")!)
            }
        }
    }
    
    // MARK: - Components
    
    private var darkModeToggle: some View {
        @Bindable var manager = themeManager
        
        return HStack {
            Text("Тёмная тема")
                .foregroundColor(.yBlack)
            Spacer()
            ToggleView(isOn: Binding(
                get: { themeManager.selectedTheme == .dark },
                set: { newValue in
                    themeManager.selectedTheme = newValue ? .dark : .light
                }
            ))
        }
        .frame(height: 60)
    }
    
    private var userAgreementLink: some View {
        Button {
            showUserAgreement = true
        } label: {
            ListCellView(title: "Пользовательское соглашение")
        }
        .frame(height: 60)
    }
    
    private var footerInfo: some View {
        VStack(spacing: 16) {
            Text("Приложение использует API «Яндекс.Расписания»")
            Text("Версия 1.0 (beta)")
        }
        .font(.caption)
        .foregroundColor(.yBlack)
    }
}

#Preview {
    SettingsView()
        .environment(ThemeManager.shared)
}
