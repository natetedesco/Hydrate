//
//  Test.swift
//  Hydrate
//
//  Created by Developer on 9/26/25.
//

import SwiftUI


struct ScrollDemo: View {
    @State private var selectedIndex = 0
    
    let items = ["One", "Two", "Three", "Four"]
    
    var body: some View {
        GeometryReader { geometry in
            let cardWidth = geometry.size.width - 200
            
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    ForEach(items.indices, id: \.self) { index in
                        GeometryReader { proxy in
                            let midX = proxy.frame(in: .global).midX
                            let isSelected = selectedIndex == index
                            
                            Text(items[index])
                                .frame(width: cardWidth, height: 160)
                                .background(isSelected ? Color.blue : Color.gray.opacity(0.3))
                                .cornerRadius(28)
                                .scaleEffect(isSelected ? 1.05 : 1.0)
                                .animation(.easeInOut(duration: 0.2), value: isSelected)
                                .onChange(of: midX) { newValue in
                                    let center = geometry.frame(in: .global).midX
                                    if abs(newValue - center) < 30 {
                                        selectedIndex = index
                                    }
                                }
                        }
                        .frame(width: cardWidth, height: 160)
                    }
                }
                .padding(.horizontal, selectedIndex == 0 ? 80: 0)
            }
            .scrollTargetBehavior(.paging)
            .scrollTargetLayout()
            .scrollIndicators(.hidden)
            .contentMargins(.horizontal, 32)
        }
        .frame(height: 200)
    }
}

#Preview { ScrollDemo() }
