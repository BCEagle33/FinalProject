//
//  MovieQuizView.swift
//  MovieCompanion
//
//  Created by Tyler on 4/24/23.
//

import SwiftUI
import AVFAudio

struct MovieQuizView: View {
    
    @FocusState private var textFieldIsFocused: Bool
    
    @StateObject var moviesVM = MovieViewModel()
    
    @EnvironmentObject var leaderboardVM: LeaderboardViewModel
    
    @State var movie: Movie
    
    @State private var quizColorYear: Color = .black
    @State private var quizColorRating: Color = .black
    @State private var quizColorRelease: Color = .black
    @State private var quizColorLength: Color = .black
    @State private var quizColorGenre: Color = .black
    @State private var quizColorDirector: Color = .black
    @State private var quizColorActors: Color = .black
    @State private var quizColorMetaScore: Color = .black
    @State private var quizColorImdbScore: Color = .black
    @State private var quizColorBoxOffice: Color = .black
    @State var year = ""
    @State var rating = ""
    @State var release = ""
    @State var length = ""
    @State var genre = ""
    @State var director = ""
    @State var actors = ""
    @State var metaScore = ""
    @State var imdbScore = ""
    @State var boxOffice = ""
    @State var scoreTest = false
    
    @State private var audioPlayer: AVAudioPlayer!
    
    @State var name = ""
    
    @State private var counter = 0
    
    
    var body: some View {
            ZStack {
                Rectangle()
                    .fill(.yellow.opacity(0.2))
                    .ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .leading, spacing: 3) {
                        Text("Movie Quiz: \(movie.Title)")
                            .font(.custom("ChalkboardSE-Bold", fixedSize: 30))
                            .foregroundColor(.black.opacity(0.9))
                            .lineLimit(2)
                            .minimumScaleFactor(0.5)
                            .fontWeight(.light)
                            .padding()
                    
                        
                        Rectangle()
                            .frame(width: .infinity, height: 2)
                            .padding()
                        Group {
                            TextField("Enter Player Name", text: $name)
                                .textFieldStyle(.roundedBorder)
                            
                            Rectangle()
                                .fill(.black.opacity(0.5))
                                .frame(width: .infinity, height: 8)
                            
                            
                            TextField("Movie Release Year", text: $year)
                                .textFieldStyle(.roundedBorder)
                                .foregroundColor(quizColorYear)
                            
                            TextField("Movie Age Rating", text: $rating)
                                .textFieldStyle(.roundedBorder)
                                .foregroundColor(quizColorRating)
                            
                            TextField("Locations Movie Released", text: $release)
                                .textFieldStyle(.roundedBorder)
                                .foregroundColor(quizColorRelease)
                            
                            TextField("Movie Length [ --- min]", text: $length)
                                .textFieldStyle(.roundedBorder)
                                .foregroundColor(quizColorLength)
                            
                            TextField("Movie Genre", text: $genre)
                                .textFieldStyle(.roundedBorder)
                                .foregroundColor(quizColorGenre)
                            
                            TextField("Movie Director/s", text: $director)
                                .textFieldStyle(.roundedBorder)
                                .foregroundColor(quizColorDirector)
                            
                            TextField("Movie Actors", text: $actors)
                                .textFieldStyle(.roundedBorder)
                                .foregroundColor(quizColorActors)
                            
                            TextField("Movie Metascore", text: $metaScore)
                                .textFieldStyle(.roundedBorder)
                                .foregroundColor(quizColorMetaScore)
                        }
                        
                        Group{
                            TextField("Movie imdb Score", text: $imdbScore)
                                .textFieldStyle(.roundedBorder)
                                .foregroundColor(quizColorImdbScore)
                            TextField("Movie Box Office Sales", text: $boxOffice)
                                .textFieldStyle(.roundedBorder)
                                .foregroundColor(quizColorBoxOffice)
                        }
                        
                        HStack {
                                Button("Check Your Answers!") {
                                    if counter == 0 {
                                        checkAnswers()
                                        addToScoreboard()
                                        playSound(soundName: "Smart.net.mp3")
                                    }
                                    
                                    scoreTest = true
                                    
                                }
                                .buttonStyle(.borderedProminent)
                                .tint(.black)
                                .font(.title2)
                            
                            Button("New Movie") {
                                playSound(soundName: "PlayAgain.net")
                                
                                
                                var newMovie = moviesVM.movies.randomElement()!
                                while newMovie.id == movie.id {
                                    newMovie = moviesVM.movies.randomElement()!
                                }
                                movie = newMovie
                                
                                scoreTest = false
                                counter = 0
                                
                                year = ""
                                rating = ""
                                release = ""
                                length = ""
                                genre = ""
                                director = ""
                                actors = ""
                                metaScore = ""
                                imdbScore = ""
                                boxOffice = ""
                                
                                quizColorYear = .black
                                quizColorRating = .black
                                quizColorRelease = .black
                                quizColorLength = .black
                                quizColorGenre = .black
                                quizColorDirector = .black
                                quizColorActors = .black
                                quizColorMetaScore = .black
                                quizColorImdbScore = .black
                                quizColorBoxOffice = .black
                                
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.black)
                            .font(.title2)
                            .padding()
                                
                        }
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                        .padding()
                        
                        if scoreTest == false {
                            Text("Your Score:")
                                .foregroundColor(.black)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .padding()
                        } else {
                            Text("Your Score: \(counter)/10")
                                .foregroundColor(.red)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .padding()
                        }
                        
                        
                        Spacer()
                        
                        
                        
                        Spacer()

                        
                    }
                }
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
    
    func addToScoreboard() {
        let newScore = String(counter) + "/" + "10"
        
        let newMovieTitle = movie.Title
        
        leaderboardVM.addToLeaderboard(playerName: name, score: newScore, movie: newMovieTitle)
    }
    
    func checkAnswers() {
        if movie.Year == year {
            counter += 1
            quizColorYear = .green
        } else {
            quizColorYear = .red
        }
        if movie.Released == release {
            counter += 1
            quizColorRelease = .green
        } else {
            quizColorRelease = .red
        }
        if movie.Rated == rating {
            counter += 1
            quizColorRating = .green
        } else {
            quizColorRating = .red
        }
        if movie.Runtime == length {
            counter += 1
            quizColorLength = .green
        } else {
            quizColorLength = .red
        }
        if movie.Genre == genre {
            counter += 1
            quizColorGenre = .green
        } else {
            quizColorGenre = .red
        }
        if movie.Director == director {
            counter += 1
            quizColorDirector = .green
        } else {
            quizColorDirector = .red
        }
        if movie.Actors == actors {
            counter += 1
            quizColorActors = .green
        } else {
            quizColorActors = .red
        }
        if movie.Metascore == metaScore {
            counter += 1
            quizColorMetaScore = .green
        } else {
            quizColorMetaScore = .red
        }
        if movie.imdbRating == imdbScore {
            counter += 1
            quizColorImdbScore = .green
        } else {
            quizColorImdbScore = .red
        }
        if movie.BoxOffice == boxOffice {
            counter += 1
            quizColorBoxOffice = .green
        } else {
            quizColorBoxOffice = .red
        }
        
    }
    
    
}

struct MovieQuizView_Previews: PreviewProvider {
    static var previews: some View {
        MovieQuizView(movie: Movie(Title: "IDK", Year: "IDK", Rated: "IDK", Released: "IDK", Runtime: "IDK", Genre: "IDK", Director: "IDK", Actors: "IDK", Country: "IDK", Awards: "IDK", Poster: "IDK", Metascore: "IDK", imdbRating: "IDK", BoxOffice: "IDK"))
            .environmentObject(LeaderboardViewModel())
            
    }
}
