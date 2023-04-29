//
//  Leaderboard.swift
//  MovieCompanion
//
//  Created by Tyler on 4/28/23.
//

import Foundation

struct Leaderboard: Identifiable, Codable {
    var id = UUID().uuidString
    var name: String
    var score: String
    var movie: String
}
