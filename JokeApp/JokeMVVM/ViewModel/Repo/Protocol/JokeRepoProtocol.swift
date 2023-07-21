//
//  JokeProtocol.swift
//  JokeApp
//
//  Created by Ankit Yadav on 10/06/23.
//

import Foundation

protocol JokeRepoProtocol: RootRepository {
    var interactor: JokeNetworkingProtocol? { get set }
    func getJokes(completionHandler: @escaping (Result<JokeResponse, APIError>) -> Void)
   
}

protocol JokeCDRepoProtocol: RootRepositoryCDEntity {
    func getAllJokeList(completionHandler: @escaping ([JokeModel.JokeCell]) -> Void)
    func insertJokeList(jokeModel: JokeModel.JokeCell) -> Bool
    func deleteJoke() ->  Bool
}
