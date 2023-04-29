//
//  Leaderboard View Model.swift
//  MovieCompanion
//
//  Created by Tyler on 4/28/23.
//

import Foundation
@MainActor

class LeaderboardViewModel: ObservableObject {
    
    @Published var leaderboardList: [Leaderboard] = []
    
    init() {
        loadData()
    }
    
    func addToLeaderboard (playerName: String, score: String, movie: String) {
        leaderboardList = leaderboardList + [Leaderboard(name: playerName, score: score, movie: movie)]
        saveData()
    }
    
    
    func saveData() {
        let path = URL.documentsDirectory.appending(component: "leaderboardList")
        let data = try? JSONEncoder().encode(leaderboardList) // try? means if error is thrown, data = nil
        do {
            try data?.write(to: path)
        } catch {
            print("😡 ERROR: Could not save data \(error.localizedDescription)")
        }
    }
    
    func deleteLeaderboard(indexSet: IndexSet) {
        leaderboardList.remove(atOffsets: indexSet)
        saveData()
    }
    
    func loadData() {
        let path = URL.documentsDirectory.appending(component: "leaderboardList")
        guard let data = try? Data(contentsOf: path) else {return}
        do {
            leaderboardList = try JSONDecoder().decode(Array<Leaderboard>.self, from: data)
        } catch {
            print("😡 ERROR: Could not load data \(error.localizedDescription)")
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
