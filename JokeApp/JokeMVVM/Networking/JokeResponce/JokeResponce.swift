//
//  JokeResponce.swift
//  JokeApp
//
//  Created by Ankit Yadav on 10/06/23.
//

import Foundation


struct JokeResponse:Decodable {
    var joke: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        joke = try container.decode(String.self)
    }
}

