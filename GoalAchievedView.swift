//
//  GoalAchievedView.swift
//  Hydrate
//
//  Created by Developer on 9/26/25.
//

import SwiftUI

struct GoalAchievedView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Spacer()
                
                // Success icon with animation
                Image(systemName: "checkmark.circle.fill")
                    .fontWeight(.black)
                    .font(.system(size: 56))
                    .foregroundColor(.accentColor)
                    .scaleEffect(1.0)
                    .animation(.easeInOut(duration: 0.6).repeatCount(1, autoreverses: false), value: true)
                
                // Success message
                VStack(spacing: 12) {
                    Text("Goal Achieved!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text("Congratulations! You've reached your daily water intake goal.")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
                
                Spacer()
                
                // Done button
                Button(action: {
                    dismiss()
                }) {
                    Text("Awesome!")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 24)
                        .background(.accent, in: .capsule)
                        .foregroundColor(.white)
            }
            }
            .padding(.horizontal, 24)
            .navigationTitle("Daily Goal")
            .navigationBarTitleDisplayMode(.inline)
            .background(backgroundColor)
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
    GoalAchievedView()
}

