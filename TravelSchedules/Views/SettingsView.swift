//
//  SettingsView.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 12.10.2025.
//

import SwiftUI

struct SettingsView: View {
    @State private var isDarkMode = false
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
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .onAppear {
            isDarkMode = (ThemeStorage.shared.selectedTheme == .dark)
        }
    }
    
    // MARK: - Components
    
    private var darkModeToggle: some View {
        HStack {
            Text("Темная тема")
                .foregroundColor(.yBlack)
            Spacer()
            ToggleView(isOn: $isDarkMode)
                .onChange(of: isDarkMode) { oldValue, newValue in
                    ThemeStorage.shared.selectedTheme = newValue ? .dark : .light
                }
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
}
