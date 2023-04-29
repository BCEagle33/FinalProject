//
//  MovieCompanionApp.swift
//  MovieCompanion
//
//  Created by Tyler on 4/23/23.
//

import SwiftUI

@main
struct MovieCompanionApp: App {
    @StateObject var leaderboardVM = LeaderboardViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainPageView()
                .environmentObject(MovieViewModel())
                .environmentObject(LeaderboardViewModel())
        }
    }
}
