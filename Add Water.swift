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
    
    let waterOptions = [
        (amount: 1.0, title: "Glass", subtitle: "8 fl oz", icon: "cup.and.saucer.fill"),
        (amount: 2.0, title: "Large Glass", subtitle: "16 fl oz", icon: "takeoutbag.and.cup.and.straw.fill"),
        (amount: 3.0, title: "Bottle", subtitle: "24 fl oz", icon: "waterbottle.fill"),
        (amount: 4.0, title: "Large Bottle", subtitle: "32 fl oz", icon: "waterbottle.fill")
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                VStack(spacing: 8) {
//                    Image(systemName: "drop.circle.fill")
//                        .font(.system(size: 40))
//                        .foregroundColor(.accent)
                    
                    Text("Add Water")
                        .font(.title2)
                        .fontWeight(.semibold)

                }
//                .padding(.bottom)
                
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 16) {
                    ForEach(waterOptions.indices, id: \.self) { index in
                        let option = waterOptions[index]
                        
                        Button(action: {
                            waterIntake += option.amount
                            dismiss()
                        }) {
                            VStack(spacing: 8) {
                                Image(systemName: option.icon)
                                    .font(.system(size: 24))
                                    .foregroundColor(.accent)
                                
                                VStack(spacing: 4) {
                                    Text(option.title)
                                        .font(.headline)
                                        .fontWeight(.medium)
                                    
                                    Text(option.subtitle)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical)
                            .background(.accent.opacity(0.1))
                            .cornerRadius(32)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
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
                .presentationDetents([.height(300)])
        }
}
