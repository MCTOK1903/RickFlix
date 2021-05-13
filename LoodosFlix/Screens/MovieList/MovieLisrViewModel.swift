//
//  MovieLisrViewModel.swift
//  LoodosFlix
//
//  Created by Celal Tok on 13.05.2021.
//

import Foundation
import Alamofire

protocol MovielistProtocol {
    func searchMovie(movieName:String, onSuccess: @escaping (Movie?) -> Void, onError: @escaping (AFError) -> Void)
}

final class MovieListViewModel: MovielistProtocol {

    // MARK: Properties
    
    private var service: ServicesProtocol
    
    // MARK: Lifecycle
    
    init(service:ServicesProtocol) {
        self.service = service
    }
}

// MARK: Public Funcs

extension MovieListViewModel {
    func searchMovie(movieName:String, onSuccess: @escaping (Movie?) -> Void, onError: @escaping (AFError) -> Void) {
        service.searchMovie(movieName: movieName, paramaters: nil, data: nil) { movie in
            onSuccess(movie)
        } onError: { error in
            onError(error)
        }
    }
}
