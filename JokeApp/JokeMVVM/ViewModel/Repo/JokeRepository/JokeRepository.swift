//
//  JokeRepository.swift
//  JokeApp
//
//  Created by Ankit Yadav on 10/06/23.
//

import Foundation

class JokeRepository: JokeRepoProtocol {
    var interactor: JokeNetworkingProtocol?
    
    func getJokes(completionHandler: @escaping (Result<JokeResponse, APIError>) -> Void) {
        interactor?.getJoke(completionHandler: { [weak self] joke in
            guard let self = self else { return }
            switch joke {
            case .success(let response):
                completionHandler(.success(response))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
}

