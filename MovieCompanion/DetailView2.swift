//
//  DetailView2.swift
//  MovieCompanion
//
//  Created by Tyler on 4/28/23.
//

import SwiftUI

struct DetailView2: View {
    let movie: Movie
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue.opacity(0.1))
                .ignoresSafeArea()
            
            VStack{
                VStack(alignment: .leading, spacing: 2) {
                    Text("Movie Info Page: \(movie.Title)")
                        .foregroundColor(.black)
                        .font(.custom("ChalkboardSE-Bold", fixedSize: 30))
                        .fontWeight(.medium)
                        .lineLimit(2)
                        .minimumScaleFactor(0.8)
                        
                    
                    Rectangle()
                        .frame(width: .infinity, height: 2)
                        .padding()
                    Group{
                        HStack {
                            Text("Year of Release:")
                                .foregroundColor(.blue)
                            Text(movie.Year)
                        }
                        .font(.title3)
                        .fontWeight(.light)
                        
                        HStack {
                            Text("Rating:")
                                .foregroundColor(.blue)
                            
                            Text(movie.Rated)
                        }
                        .font(.title3)
                        .fontWeight(.light)
                        
                        HStack {
                            Text("Length:")
                                .foregroundColor(.blue)
                            
                            Text(movie.Runtime)
                        }
                        .font(.title3)
                        .fontWeight(.light)
                        
                        HStack {
                            Text("Genre:")
                                .foregroundColor(.blue)
                            
                            Text(movie.Genre)
                        }
                        .lineLimit(2)
                        .font(.title3)
                        .fontWeight(.light)
                        
                        HStack {
                            Text("Director/s:")
                                .foregroundColor(.blue)
                            
                            Text(movie.Director)
                        }
                        .font(.title3)
                        .fontWeight(.light)
                        
                        HStack {
                            Text("Main Actors:")
                                .foregroundColor(.blue)
                            
                            Text(movie.Actors)
                                .lineLimit(2)
                                .minimumScaleFactor(0.5)
                        }
                        .font(.title3)
                        .fontWeight(.light)
                    }
                    Group{
                        HStack {
                            Text("Country:")
                                .foregroundColor(.blue)
                            
                            Text(movie.Country)
                                
                        }
                        .font(.title3)
                        .fontWeight(.light)
                        
                        HStack {
                            Text("Awards:")
                                .foregroundColor(.blue)
                            
                            Text(movie.Awards)
                                .lineLimit(2)
                                .minimumScaleFactor(0.5)
                        }
                        .font(.title3)
                        .fontWeight(.light)
                        
                        HStack {
                            Text("Metascore:")
                                .foregroundColor(.blue)
                            
                            Text(movie.Metascore)
                        }
                        .font(.title3)
                        .fontWeight(.light)
                        
                        HStack {
                            Text("imdbRating:")
                                .foregroundColor(.blue)
                            
                            Text(movie.imdbRating)
                        }
                        .font(.title3)
                        .fontWeight(.light)
                        
                        HStack {
                            Text("Box Office Sales:")
                                .foregroundColor(.blue)
                            
                            Text(movie.BoxOffice)
                        }
                        .font(.title3)
                        .fontWeight(.light)
                    }
                    
                }
                .padding()
                
                
                AsyncImage(url: URL(string: movie.Poster)) {image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .shadow(radius: 40)
                        
                } placeholder: {
                    ProgressView()
                        .progressViewStyle(.automatic)
                        .scaleEffect(5)
                        .tint(.blue)
                }
                
                
                
                
                
            }
        }
    }
    
    struct DetailView2_Previews: PreviewProvider {
        static var previews: some View {
            DetailView2(movie: Movie(Title: "Transformers", Year: "1999", Rated: "PG", Released: "March 19, 1999", Runtime: "1 Hour", Genre: "Action", Director: "John Smith", Actors: "John Smith", Country: "America", Awards: "Best Picture", Poster: "...", Metascore: "5.5", imdbRating: "5.5", BoxOffice: "$2M"))
        }
    }
}
