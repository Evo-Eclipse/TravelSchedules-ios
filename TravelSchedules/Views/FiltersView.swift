//
//  FiltersView.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 12.10.2025.
//

import SwiftUI

struct FiltersView: View {
    @Environment(\.dismiss) private var dismiss
    @State var viewModel: FiltersViewModel
    var onApply: () -> Void
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.yWhite
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 24) {
                    // Time filters section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Время отправления")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.yBlack)
                        
                        ForEach(TimeRange.allCases, id: \.self) { range in
                            TimeRangeCheckbox(
                                title: range.rawValue,
                                isSelected: viewModel.selectedTimeRanges.contains(range)
                            ) {
                                viewModel.toggleTimeRange(range)
                            }
                        }
                    }
                    
                    // Transfers filter section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Показывать варианты с пересадками")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.yBlack)
                        
                        TransferOption(
                            title: "Да",
                            isSelected: viewModel.showWithTransfers == true
                        ) {
                            viewModel.showWithTransfers = viewModel.showWithTransfers == true ? nil : true
                        }
                        
                        TransferOption(
                            title: "Нет",
                            isSelected: viewModel.showWithTransfers == false
                        ) {
                            viewModel.showWithTransfers = viewModel.showWithTransfers == false ? nil : false
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.top, 24)
                
                // Apply button at bottom
                if viewModel.hasActiveFilters {
                    VStack {
                        Spacer()
                        
                        Button {
                            onApply()
                        } label: {
                            Text("Применить")
                                .bold()
                                .foregroundColor(.yWhiteUniversal)
                                .frame(maxWidth: .infinity)
                                .padding(20)
                                .background(Color.yBlue)
                                .cornerRadius(16)
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.yBlack)
                    }
                }
            }
        }
    }
}

struct TimeRangeCheckbox: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(title)
                    .font(.system(size: 17))
                    .foregroundColor(.yBlack)
                
                Spacer()
                
                Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    .font(.system(size: 24))
                    .foregroundColor(.yBlack)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

struct TransferOption: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(title)
                    .font(.system(size: 17))
                    .foregroundColor(.yBlack)
                
                Spacer()
                
                Image(systemName: isSelected ? "circle.inset.filled" : "circle")
                    .font(.system(size: 24))
                    .foregroundColor(.yBlack)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    FiltersView(viewModel: FiltersViewModel()) {
        // Preview action
    }
}
