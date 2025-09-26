//
//  Add Water.swift
//  Hydrate
//
//  Created by Developer on 9/25/25.
//

import SwiftUI

struct AddWaterSheet: View {
    @Binding var waterIntake: Double
    @Environment(\.dismiss) private var dismiss
    @State private var selectedOptionIndex = 2 // Default to first option (8oz)
    
    let waterOptions = [
        (amount: 4.0, title: "Small Cup", subtitle: "4 fl oz", icon: "cup.and.saucer.fill"),
        (amount: 8.0, title: "Cup", subtitle: "8 fl oz", icon: "mug.fill"),
        (amount: 16.0, title: "Bottle", subtitle: "16 fl oz", icon: "waterbottle.fill"),
        (amount: 24.0, title: "Large Bottle", subtitle: "24 fl oz", icon: "waterbottle.fill"),
        (amount: 32.0, title: "Huge Bottle", subtitle: "32 fl oz", icon: "waterbottle.fill")
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                
                // Horizontal scroll view with water options, scrolls to selected on appear
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 64) {
                            ForEach(waterOptions.indices, id: \.self) { index in
                                let option = waterOptions[index]
                                let isSelected = selectedOptionIndex == index
                                
                                Button(action: {
                                    selectedOptionIndex = index
                                }) {
                                    VStack(spacing: 12) {
                                        Image(systemName: option.icon)
                                            .font(.system(size: 48))
                                            .foregroundColor(isSelected ? .accent : .secondary)
                                        
                                        VStack(spacing: 4) {
                                            Text(option.title)
                                                .font(.title3)
                                                .fontWeight(.semibold)
                                                .foregroundColor(isSelected ? .primary : .secondary)
                                            
                                            Text(option.subtitle)
                                                .font(.subheadline)
                                                .foregroundColor(isSelected ? .primary : .secondary)
                                        }
                                    }
                                    .scaleEffect(isSelected ? 1.2 : 1.0)
                                    .animation(.easeInOut(duration: 0.2), value: isSelected)
                                }
                                .buttonStyle(.plain)
                                .id(index)
                            }
                        }
                        .frame(maxHeight: .infinity)
                        .padding(.horizontal, 160)
                    }
                    .onAppear {
                        proxy.scrollTo(selectedOptionIndex, anchor: .center)
                    }
                }
                
                Spacer()
                
                // Add button at the bottom
                Button(action: {
                    waterIntake += waterOptions[selectedOptionIndex].amount
                    dismiss()
                }) {
                    HStack {
                        Text("Add \(waterOptions[selectedOptionIndex].subtitle)")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    .font(.title3)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 24)
                    .background(.accent, in: .capsule)
                    .foregroundColor(.white)
                }
                .padding(.horizontal, 24)
            }
            .navigationTitle("Add Water")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("", systemImage: "xmark") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .sheet(isPresented: .constant(true)) {
            AddWaterSheet(waterIntake: .constant(20))
                .presentationDetents([.medium])
        }
}
