//
//  ViewModel.swift
//  JokeApp
//
//  Created by Ankit Yadav on 10/06/23.
//

import Foundation

class JokeViewModel:RootViewModel {
    
    var bindJokeViewModelToController : (() -> ()) = {}
    var timer: DispatchSourceTimer?
    
    func configure() {
        getJokeListFromDB()
        _ = Timer.scheduledTimer(timeInterval: 60.0,
                                         target: self,
                                         selector: #selector(updateTimer),
                                         userInfo: nil,
                                         repeats: true)
    }
    
    @objc func updateTimer() {
        print("1 min passed")
        self.getJokeList()
    }
    private func getJokeListFromDB() {
        if let repository = repository as? JokeRepository {
            guard var rootModel = self.rootModel as? JokeModel.Root
            else { return }
            repository.getAllJokeList { jokeList in
                if jokeList.count == 0 {
                    return
                } else {
                    rootModel.update(value: jokeList.reversed())
                    self.rootModel = rootModel
                    self.bindJokeViewModelToController()
                }
            }
        }
    }
    
    private func getJokeList() {
        if let repository = repository as? JokeRepository {
            repository.getJokes { [weak self] joke in
                guard let self = self else { return }
                switch joke {
                case .success(let data):
                    guard var rootModel = self.rootModel as? JokeModel.Root
                    else { return }
                    rootModel.update(value: self.createListCell(element: data) )
                    _ = repository.insertJokeList(jokeModel: self.createListCell(element: data) )
                    if rootModel.data.count >= 11 {
                        rootModel.delete()
                        _ = repository.deleteJoke()
                    }
                    self.rootModel = rootModel
                    self.bindJokeViewModelToController()
                case .failure(let error):
                    switch error.type {
                    case .noInternet:
                        print (StringConstants.GenericError.noInternet)
                    default:
                        print (StringConstants.GenericError.serviceUnavailable)
                    }
                }
            }
        }
    }
    
    
    private func createListCell(element: JokeResponse) -> JokeModel.JokeCell {
        let cell = JokeModel.JokeCell(
            cellIdentifier: StringConstants.cellIdentifiers.cellIdentifier,
            text: element.joke ?? ""
        )
        return cell
    }
}
