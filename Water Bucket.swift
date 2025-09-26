//
//  Water Bucket.swift
//  Hydrate
//
//  Created by Developer on 9/25/25.
//

import SwiftUI

struct WaterBucket: View {
    @State private var waveOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            // Outer circle container
            Circle()
                .fill(.primary.opacity(0.05))
                .stroke(Color.primary.opacity(0.05), lineWidth: 3)
                .frame(width: 240, height: 240)
            
            // Wave layers with proper clipping
            ZStack {
                // Back wave
                WaveShape(offset: waveOffset, amplitude: 15, frequency: 1.2)
                    .fill(
                        LinearGradient(
                            colors: [Color.accent.opacity(0.8), Color.accent.opacity(0.6)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                
                // Front wave
                WaveShape(offset: waveOffset + 50, amplitude: 10, frequency: 1.5)
                    .fill(
                        LinearGradient(
                            colors: [Color.accent.opacity(0.9), Color.accent.opacity(0.7)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
            }
            .frame(width: 240, height: 240)
            .clipShape(Circle())
        }
        .onAppear {
            // Animate the waves much slower
            withAnimation(.linear(duration: 8).repeatForever(autoreverses: false)) {
                waveOffset = 360
            }
        }
    }
}

struct WaveShape: Shape {
    var offset: CGFloat
    let amplitude: CGFloat
    let frequency: CGFloat
    
    var animatableData: CGFloat {
        get { offset }
        set { offset = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        let midHeight = height * 0.5
        
        path.move(to: CGPoint(x: 0, y: midHeight))
        
        for x in stride(from: 0, through: width, by: 2) {
            let relativeX = x / width
            let sine = sin((relativeX * frequency * 2 * .pi) + (offset * .pi / 180))
            let y = midHeight + sine * amplitude
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        // Complete the shape by drawing to bottom corners
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        
        return path
    }
}

#Preview {
    WaterBucket()
}
