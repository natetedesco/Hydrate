//
//  StreakView.swift
//  Hydrate
//
//  Created by Developer on 9/25/25.
//

import SwiftUI

struct StreakView: View {
    @Environment(\.dismiss) private var dismiss
    
    // Mock streak data - in a real app you'd store this in UserDefaults or Core Data
    @State private var currentStreak: Int = 7
    @State private var longestStreak: Int = 15
    @State private var streakHistory: [Date] = {
        let calendar = Calendar.current
        return Array(0..<7).compactMap { daysAgo in
            calendar.date(byAdding: .day, value: -daysAgo, to: Date())
        }
    }()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 8) {
                    Image(systemName: "flame.fill")
                        .font(.system(size: 72))
                        .fontWeight(.black)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.accentColor, Color.accentColor.opacity(0.7)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    
                    Text("\(currentStreak)")
                        .fontDesign(.default)
                        .fontWidth(.condensed)
                        .font(.system(size: 96))
                        .fontWeight(.black)
                        .padding(24)
                        .foregroundStyle(LinearGradient(
                            colors: [.accentColor, Color.accentColor.opacity(0.8)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .padding(.bottom, -16)
                    
                    Text("day streak")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.bottom, 32)
                    
                    
                    // Weekly Calendar View
                    VStack(alignment: .leading, spacing: 12) {
                        Text("This Week")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        HStack(spacing: 12) {
                            ForEach(0..<7, id: \.self) { dayIndex in
                                let calendar = Calendar.current
                                let date = calendar.date(byAdding: .day, value: -dayIndex, to: Date()) ?? Date()
                                let isCompleted = streakHistory.contains { calendar.isDate($0, inSameDayAs: date) }
                                let dayFill: AnyShapeStyle = isCompleted
                                    ? AnyShapeStyle(LinearGradient(colors: [Color.accentColor, Color.accentColor.opacity(0.7)], startPoint: .top, endPoint: .bottom))
                                    : AnyShapeStyle(Color.gray.opacity(0.2))
                                
                                VStack(spacing: 6) {
                                    Text(dayOfWeek(for: date))
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                    
                                    Circle()
                                        .fill(dayFill)
                                        .frame(width: 32, height: 32)
                                        .overlay {
                                            if isCompleted {
                                                Image(systemName: "drop.fill")
                                                    .font(.caption)
                                                    .foregroundColor(.white)
                                            }
                                        }
                                    
                                    Text("\(calendar.component(.day, from: date))")
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                }
                                .accessibilityLabel("Day \(calendar.component(.day, from: date))" + (isCompleted ? ", completed" : ""))
                            }
                        }
                    }
                    .padding()
                    .background(.bar)
                    .cornerRadius(20)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Streak")
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
    
    private func dayOfWeek(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: date)
    }
}

#Preview {
    StreakView()
        .fontDesign(.rounded)
}
