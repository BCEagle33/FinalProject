//
//  MovieViewModel.swift
//  MovieCompanion
//
//  Created by Tyler on 4/23/23.
//

import Foundation

@MainActor
class MovieViewModel: ObservableObject {
    @Published var apiKey = "9d1ff79b"
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var movieSearch = ""
    
    
    init() {
        loadData()
    }
    
    func getData() async {
        
        isLoading = true
        
        let newMovieSearch = movieSearch.replacingOccurrences(of: " ", with: "-")
        
        let urlString = "https://www.omdbapi.com/?t=\(newMovieSearch)&apikey=\(apiKey)"
        print("🕸️ We are accessing the url \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not convert \(urlString) to a URL")
            isLoading = false
            return
        }
        
        do {
           let (data, _) = try await URLSession.shared.data(from: url)
            do {
                let movies = try JSONDecoder().decode(Movie.self, from: data)

                self.movies = self.movies + [movies]
                isLoading = false
                saveData()
            } catch {
                print("😡 JSON ERROR: Could not decode returned JSON data. \(error.localizedDescription)")
                isLoading = false
            }
        } catch {
            print("😡 ERROR: Could not get data from \(urlString). \(error.localizedDescription)")
            isLoading = false
        }
    }
    
    func saveData() {
        let path = URL.documentsDirectory.appending(component: "movies")
        let data = try? JSONEncoder().encode(movies) // try? means if error is thrown, data = nil
        do {
            try data?.write(to: path)
        } catch {
            print("😡 ERROR: Could not save data \(error.localizedDescription)")
        }
    }
    
    func deleteMovie(indexSet: IndexSet) {
        movies.remove(atOffsets: indexSet)
        saveData()
    }
    
    func moveMovie(fromOffsets: IndexSet, toOffset: Int) {
        movies.move(fromOffsets: fromOffsets, toOffset: toOffset)
        saveData()
    }
    
    
    func loadData() {
        let path = URL.documentsDirectory.appending(component: "movies")
        guard let data = try? Data(contentsOf: path) else {return}
        do {
            movies = try JSONDecoder().decode(Array<Movie>.self, from: data)
        } catch {
            print("😡 ERROR: Could not load data \(error.localizedDescription)")
        }
    }
    
    
    
    
    
    
    
    
    
    
}
