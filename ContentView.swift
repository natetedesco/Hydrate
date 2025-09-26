//
//  ContentView.swift
//  Hydrate
//
//  Created by Developer on 9/25/25.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("waterIntake") private var waterIntake: Double = 0
    @AppStorage("dailyGoal") private var dailyGoal: Double = 64
    @AppStorage("hasShownGoalToday") private var hasShownGoalToday = false
    
    @State private var showingWaterOptions = false
    @State private var showingStreakView = false
    @State private var showingSettingsView = false
    @State private var showingGoalAchieved = false
    
    var progress: Double {
        min(waterIntake / dailyGoal, 1.0)
    }
    
    var body: some View {
        VStack(spacing: 30) {
            // Header
            VStack(spacing: 10) {
                Image("Hydrate")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .font(.system(size: 50))
                    .foregroundColor(.accent)
                    .padding(.top)
                
                Text("Hydrate")
                    .font(.title)
                    .fontWeight(.bold)
            }
            
            Spacer()
            
            WaterBucket(progress: progress)
            
            
            // Stats
            VStack {
                HStack {
                    Text("\(Int(waterIntake))")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.primary)
                    Text("/ \(Int(dailyGoal)) oz")
                        .font(.headline)
                }
            }
            
            Spacer()
            HStack {
                Button(action: {
                    showingSettingsView = true
                }) {
                    HStack {
                        Image(systemName: "gearshape.fill")
                    }
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                    .frame(width: 52, height: 52)
                    .background(.bar, in: Circle())
                    .glassEffect()
                }
                
                Spacer()
                Button(action: {
                    showingWaterOptions = true
                }) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Water")
                    }
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(24)
                    .background(.accent, in: Capsule())
                    .glassEffect()
                }
                Spacer()
                
                Button(action: {
                    showingStreakView = true
                }) {
                    HStack {
                        Image(systemName: "drop.fill")
                    }
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                    .frame(width: 52, height: 52)
                    .background(.bar, in: Circle())
                    .glassEffect()
                }
            }.padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .background(backgroundColor)
        .sheet(isPresented: $showingWaterOptions) {
            AddWaterSheet(waterIntake: $waterIntake)
                .presentationDetents([.height(400)])
        }
        .sheet(isPresented: $showingStreakView) {
            StreakView()
        }
        .sheet(isPresented: $showingSettingsView) {
            SettingsView(dailyGoal: $dailyGoal)
        }
        .fullScreenCover(isPresented: $showingGoalAchieved) {
            GoalAchievedView()
        }
        .onChange(of: waterIntake) { _, newValue in
            // Check if goal is reached and we haven't shown the sheet today
            if newValue >= dailyGoal && !hasShownGoalToday {
                showingGoalAchieved = true
                hasShownGoalToday = true
            }
        }
    }
}



#Preview {
    ContentView()
        .fontDesign(.rounded)
}
