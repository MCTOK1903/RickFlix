//
//  Codable+Alamofire.swift
//  LoodosFlix
//
//  Created by Celal Tok on 13.05.2021.
//

import Foundation

extension Encodable {
    func asDictionary() throws -> [String:Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(
                with: data,
                options: .allowFragments
        ) as? [String:Any]
        else { throw NSError() }
        return dictionary
    }
}
