//
//  JokeNetworkingProtocol.swift
//  JokeApp
//
//  Created by Ankit Yadav on 10/06/23.
//

import Foundation

protocol JokeNetworkingProtocol: AnyObject {
    func getJoke(completionHandler: @escaping (Result<JokeResponse, APIError>) -> Void)
}
