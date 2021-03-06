//
//  MovieLisrViewModel.swift
//  LoodosFlix
//
//  Created by Celal Tok on 13.05.2021.
//

import Foundation
import Alamofire
import Firebase

protocol MovielistProtocol {
    func searchMovie(movieName:String, onSuccess: @escaping (Movie?) -> Void, onError: @escaping (AFError) -> Void)
    func getMovieDetail(movieID: String, onSuccess: @escaping (MovieDetail?) -> Void, onError: @escaping (AFError) -> Void)
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
    
    func getMovieDetail(movieID: String, onSuccess: @escaping (MovieDetail?) -> Void, onError: @escaping (AFError) -> Void) {
        service.getMovieDetail(movieID: movieID) { [weak self] movieDetail in
            guard let self =  self, let movieDetail = movieDetail else {
                onSuccess(nil)
                return }
            self.logDetailScreenEvent(movieTitle: movieDetail.title)
            onSuccess(movieDetail)
        } onError: { error in
            onError(error)
        }
    }
    
    private func logDetailScreenEvent(movieTitle: String) {
        FirebaseAnalytics.Analytics.logEvent(Constant.FirebaseConsant.LOG_EVENT_NAME, parameters: [
            AnalyticsParameterScreenName: Constant.FirebaseConsant.LOG_EVENT_NAME,
            Constant.FirebaseConsant.PRODUCT_NAME: movieTitle,
        ])
    }
}
