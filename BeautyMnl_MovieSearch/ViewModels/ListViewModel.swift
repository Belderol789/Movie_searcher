//
//  ListViewModel.swift
//  BeautyMnl_MovieSearch
//
//  Created by iOSDev on 3/24/21.
//

import Foundation
// MARK: - Protocol
protocol ListViewModelProtocol {
    func returnListOfMovies(_ movies: [Movie])
    func returnEmptyMovieList()
}

class ListViewModel {
    // MARK: - Variables
    private let apiManager = APIManager()
    public var delegate: ListViewModelProtocol? = nil
    
    // MARK: - List Functions
    func retrievListOfMovies(searchText: String) {
        apiManager.searchMovies(searchText: searchText) { [weak self] (movies) in
            DispatchQueue.main.async {
                if movies.isEmpty {
                    self?.delegate?.returnEmptyMovieList()
                } else {
                    self?.delegate?.returnListOfMovies(movies)
                }
            }
        }
    }
}
