//
//  Services.swift
//  LoodosFlix
//
//  Created by Celal Tok on 13.05.2021.
//

import Foundation
import Alamofire


protocol ServicesProtocol {
    func searchMovie(movieName: String, paramaters: [String: Any]?, data: Codable?, onSuccess: @escaping (Movie?) -> Void, onError: @escaping (AFError) -> Void)
    func getMovieDetail(movieID: String, onSuccess: @escaping (MovieDetail?) -> Void, onError: @escaping (AFError) -> Void)
}

final class Services: ServicesProtocol {
    
    func searchMovie(movieName: String, paramaters: [String: Any]?, data: Codable?, onSuccess: @escaping (Movie?) -> Void, onError: @escaping (AFError) -> Void) {
        ServiceManager.shared.fetch(path: Constant.NetworkConstant.BASE_URL + "/?s=\(movieName)&" + Constant.NetworkConstant.API_KEY, paramaters: nil, data: nil, method: HTTPMethod.get) { (response: Movie) in
            onSuccess(response)
            print(response)
        } onError: { error in
            onError(error)
            print(error)
        }
    }
    
    func getMovieDetail(movieID: String, onSuccess: @escaping (MovieDetail?) -> Void, onError: @escaping (AFError) -> Void) {
        ServiceManager.shared.fetch(path: Constant.NetworkConstant.BASE_URL + "/?i=\(movieID)&" + Constant.NetworkConstant.API_KEY , paramaters: nil, data: nil, method: HTTPMethod.get) { (response: MovieDetail) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }
}
