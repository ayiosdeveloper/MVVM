//
//  NetworkingCall.swift
//  JokeApp
//
//  Created by Ankit Yadav on 10/06/23.
//

import Foundation

class NetworkingCall: JokeNetworkingProtocol {
    
    private let sourcesURL = URL(string: "https://geek-jokes.sameerkumar.website/api")!
    
    func getJoke(completionHandler: @escaping (Result<JokeResponse, APIError>) -> Void) {
        
        let urlRequest = URLRequest(url: sourcesURL)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 200 {
                guard let data = data else { return }
                do {
                    print(String(decoding: data, as: UTF8.self))
                    let joke = try JSONDecoder().decode(JokeResponse.self, from: data)
                    completionHandler(.success(joke))
                } catch let error {
                    print("Error decoding: ", error)
                }
            }
        }
        dataTask.resume()
    }
}

