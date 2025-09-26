//
//  Model.swift
//  Hydrate
//
//  Created by Developer on 9/25/25.
//

import Foundation


@Observable class Model {
    var dailyGoal: Double = 2000
    var unitPreference: String = "oz"   // "oz" or "ml"
    var reminderEnabled: Bool = true
    var reminderInterval: TimeInterval = 2 * 3600 // every 2 hours
    
    // Logging
    var currentIntake: Double = 0       // ml, normalized
    var progress: Double {              // % of goal
        guard dailyGoal > 0 else { return 0 }
        return min(currentIntake / dailyGoal, 1.0)
    }
    
    var streakCount: Int = 0
}
