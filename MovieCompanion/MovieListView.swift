//
//  ContentView.swift
//  MovieCompanion
//
//  Created by Tyler on 4/23/23.
//

import SwiftUI
import AVFAudio

struct MovieListView: View {
    @StateObject var moviesVM = MovieViewModel()
    @State private var path = NavigationPath()
    @State private var audioPlayer: AVAudioPlayer!
    
    var body: some View {
        NavigationStack(path: $path){
            ZStack {
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundColor(.green.opacity(0.14))
                
                VStack {
                    Group{
                        Text("My Movie Companion")
                            .font(.custom("ChalkboardSE-Bold", size: 35))
                            .fontWeight(.ultraLight)
                            .foregroundColor(.green.opacity(80))
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        Rectangle()
                            .frame(width: .infinity, height: 2)
                        
                        
                        Text("Enter API Key & Movie Title")
                            .font(.custom("ChalkboardSE-Light", size: 23))
                            .fontWeight(.ultraLight)
                            .padding()
                    }
                    HStack{
                        Text("Don't Have A Key? Use Link:")
                            .font(.custom("Copperplate-Light", size: 15))
                            .fontWeight(.light)
                            .foregroundColor(.blue)
                        Link("OMDb Website", destination: URL(string:"https://www.omdbapi.com/apikey.aspx")!)
                            .font(.custom("Copperplate-Light", size: 15))
                            .fontWeight(.light)
                            .foregroundColor(.red)
                        
                    }
                    
                    
                    TextField("Please Enter Your OMDb API Key:", text: $moviesVM.apiKey)
                        .textFieldStyle(.roundedBorder)
                        .font(.title2)
                        .fontWeight(.ultraLight)
                        .foregroundColor(.red)
                        .keyboardType(.default)
                    
                    TextField("Please Enter a Movie to Search For:", text: $moviesVM.movieSearch)
                        .textFieldStyle(.roundedBorder)
                        .font(.title2)
                        .keyboardType(.default)
                    
                    
                    Button("Find Movie Info!") {
                        Task {
                            await moviesVM.getData()
                            moviesVM.movieSearch = ""
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .font(.title3)
                    .tint(.black.opacity(20))
                    .padding()
                    
                    
                    Text("Movie Favorites List:")
                        .font(.custom("Nexa", fixedSize: 25))
                        .fontWeight(.light)
                        .multilineTextAlignment(.leading)
                    
                    
                    List {
                        ForEach(moviesVM.movies) { movie in
                            NavigationLink {
                                DetailView2(movie: movie)
                            } label: {
                                HStack{
                                    Text(movie.Title.capitalized)
                                        .font(.title2)
                                    Text("(\(movie.Year.capitalized))")
                                        .font(.title2)
                                }
                            }
                        }
                        .onDelete(perform: moviesVM.deleteMovie)
                        .onMove(perform: moviesVM.moveMovie)
                    }
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
                                .foregroundColor(.blue)
                        }
                    }
                    
                    
                    VStack{
                        Button("Movie Quiz Mini-Game") {
                            if moviesVM.movies.count != 0{
                                quizSend()
                                playSound(soundName: "it's-time-to-play-By-tuna.voicemod.net")
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.black.opacity(20))
                        .navigationDestination(for: String.self) { view in
                            if view == "QuizView" {
                                MovieQuizView(movie: moviesVM.movies.randomElement()!)
                            }
                        }
                    }
                    .lineLimit(1)
                    
                }
            }
            
        }
        if moviesVM.isLoading {
            ProgressView()
                .scaleEffect(9)
                .tint(.blue)
        }
    }
    
    func playSound(soundName: String) {
        guard let soundFile  = NSDataAsset(name: soundName) else {
            print("Could not read file named \(soundName)")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
            
        } catch {
            print("ERROR: \(error.localizedDescription) creating audioPlayer.")
        }
    }
    
    func quizSend() {
        path.append("QuizView")
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
        
    }
}
