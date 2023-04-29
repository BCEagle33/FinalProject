//
//  LeaderboardView.swift
//  MovieCompanion
//
//  Created by Tyler on 4/28/23.
//

import SwiftUI

struct LeaderboardView: View {
    @EnvironmentObject var leaderboardVM: LeaderboardViewModel
    
    var body: some View {
        NavigationStack {
            ZStack{
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundColor(.red.opacity(0.30))
                VStack{
                    Text("Scoreboard")
                        .font(.custom("ChalkboardSE-Bold", size: 35))
                        .fontWeight(.ultraLight)
                        .padding()
                    Rectangle()
                        .frame(width: .infinity, height: 2)
                    
                    
                    List {
                        ForEach(leaderboardVM.leaderboardList) { person in
                                HStack{
                                    Text("\(person.name.capitalized):")
                                        .font(.title2)
                                    Text("Score: \(person.score)")
                                        .font(.title2)
                                    Text("Movie: \(person.movie)")
                                        .font(.title2)
                                    
                                }
                            }
                        .onDelete(perform: leaderboardVM.deleteLeaderboard)
                        }
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .foregroundColor(.black)
                    .overlay {
                        RoundedRectangle(cornerRadius: 1)
                            .stroke(.black.opacity(0.6), lineWidth: 4)
                    }
                    .padding()
                    .listStyle(.automatic)
                    .toolbar{
                        ToolbarItem(placement: .bottomBar) {
                            EditButton()
                                .foregroundColor(.black)
                        }
                    }
                    
                    }
                    
            }
        }
        }
    }

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
            .environmentObject(LeaderboardViewModel())
    }
}
