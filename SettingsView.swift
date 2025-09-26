//
//  SettingsView.swift
//  Hydrate
//
//  Created by Developer on 9/25/25.
//

import SwiftUI

struct SettingsView: View {
    @Binding var dailyGoal: Double
    @Environment(\.dismiss) private var dismiss
    
    @State private var tempDailyGoal: Double = 64
    @State private var notificationsEnabled: Bool = true
    @State private var reminderInterval: Int = 2 // hours
    @State private var startTime: Date = {
        let calendar = Calendar.current
        return calendar.date(bySettingHour: 8, minute: 0, second: 0, of: Date()) ?? Date()
    }()
    @State private var endTime: Date = {
        let calendar = Calendar.current
        return calendar.date(bySettingHour: 22, minute: 0, second: 0, of: Date()) ?? Date()
    }()
    
    let reminderIntervals = [1, 2, 3, 4, 6, 8]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                List {
                    Section("Daily Goal") {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Ounces per day")
                                    .font(.body)
                                
                                Spacer()
                                
                                Text("\(Int(tempDailyGoal))")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.accent)
                            }
                            
                            Slider(value: $tempDailyGoal, in: 32...128, step: 8) {
                                Text("Daily Goal")
                            }
                            .accentColor(.accent)
                        }
                        .padding(.vertical, 4)
                    }
                    
                    Section("Reminders") {
                        Toggle("Reminder", isOn: $notificationsEnabled)
                            .tint(.accent)
                        
                        if notificationsEnabled {
                            HStack {
                                Text("Reminder Frequency")
                                Spacer()
                                Picker("", selection: $reminderInterval) {
                                    ForEach(reminderIntervals, id: \.self) { interval in
                                        Text("Every \(interval)h")
                                            .tag(interval)
                                    }
                                }
                                .pickerStyle(.menu)
                            }
                            
                            DatePicker("Start Time", selection: $startTime, displayedComponents: .hourAndMinute)
                                .datePickerStyle(.compact)
                            
                            DatePicker("End Time", selection: $endTime, displayedComponents: .hourAndMinute)
                                .datePickerStyle(.compact)
                        }
                    }
                    
                    Section("About") {
                        Text("Privacy Policy")
                            .fontWeight(.medium)
                        
                        
                        Text("Stay Hydrated!")
                            .fontWeight(.medium)
                        
                    }
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
            }
            .padding(.top)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "xmark") {
                        dailyGoal = tempDailyGoal
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            tempDailyGoal = dailyGoal
        }
    }
}

#Preview {
    SettingsView(dailyGoal: .constant(64))
        .fontDesign(.rounded)
}
