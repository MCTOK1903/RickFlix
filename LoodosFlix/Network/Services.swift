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
}

final class Services: ServicesProtocol {
    
    func searchMovie(movieName: String, paramaters: [String: Any]?, data: Codable?, onSuccess: @escaping (Movie?) -> Void, onError: @escaping (AFError) -> Void) {
        ServiceManager.shared.fetch(path: "http://www.omdbapi.com/?s=\(movieName)&apikey=cfd99f46", paramaters: nil, data: nil, method: HTTPMethod.get) { (response: Movie) in
            onSuccess(response)
            print(response)
        } onError: { error in
            onError(error)
            print(error)
        }
    }
}
