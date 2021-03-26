//
//  APIManager.swift
//  BeautyMnl_MovieSearch
//
//  Created by iOSDev on 3/24/21.
//

import Foundation

class APIManager {
    
    func searchMovies(searchText: String, movieList: @escaping ([Movie]) -> ()) {
        var movies = [Movie]()
        let query = searchText.replacingOccurrences(of: " ", with: "%20")
        URLSession.shared.dataTask(with: URL(string: "https://www.omdbapi.com/?apikey=e55825d3&s=\(query)&type=movie")!,
                                   completionHandler: { data, response, error in

                                    guard let data = data, error == nil else {
                                        movieList([])
                                        return
                                    }

                                    // Convert
                                    var result: MovieResults?
                                    do {
                                        result = try JSONDecoder().decode(MovieResults.self, from: data)
                                    }
                                    catch {
                                        movieList([])
                                    }

                                    guard let finalResult = result else {
                                        movieList([])
                                        return
                                    }

                                    // Update our movies array
                                    let newMovies = finalResult.Search
                                    movies.append(contentsOf: newMovies)

                                    // Refresh our table
                                    print("APIManager: List of movies \(movies)")
                                    movies = movies.sorted(by: {$0.Year > $1.Year})
                                    movieList(movies)
        }).resume()
    }
}
