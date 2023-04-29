//
//  MainPageView.swift
//  MovieCompanion
//
//  Created by Tyler on 4/28/23.
//

import SwiftUI

struct MainPageView: View {
    var body: some View {
        TabView{
            MovieListView()
                .tabItem{
                    Label("Movie List", systemImage: "Swift")
                }
            
            LeaderboardView()
                .tabItem{
                    Label("Scoreboard", image: "Swift")
                }
        }
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
