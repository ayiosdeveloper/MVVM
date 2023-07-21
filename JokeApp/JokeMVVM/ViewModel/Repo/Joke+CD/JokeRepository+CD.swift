//
//  JokeRepository+CD.swift
//  JokeApp
//
//  Created by Ankit Yadav on 14/06/23.
//

import Foundation
import CoreData

extension JokeRepository: JokeCDRepoProtocol {
    
    func insertJokeList(jokeModel: JokeModel.JokeCell) -> Bool {
        PersistentStorage.shared.printDocumentDirectoryPath()
        debugPrint("Joke: Insert record operation is starting")
        PersistentStorage.shared.persistentContainer.performBackgroundTask { privateManagedContext in
            let joke = CDJokeList(context: privateManagedContext)
            joke.id = UUID()
            joke.joke = jokeModel.text
            privateManagedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            if privateManagedContext.hasChanges {
                try? privateManagedContext.save()
                debugPrint("Joke: Insert record operation is completed")
            }
        }
        return true
    }
    
    func deleteJoke() -> Bool {
        let context = PersistentStorage.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDJokeList")
        fetchRequest.fetchLimit = 1
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
            try context.save()
            return true
        } catch {
            print("There was an error")
            return false
        }
    }
    
    func getAllJokeList(completionHandler: @escaping ([JokeModel.JokeCell]) -> Void) {
        var jokeData: [JokeModel.JokeCell] = []
        print("getAllJokeList")
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDJokeList")
        let context = PersistentStorage.shared.persistentContainer.viewContext
        do {
            let results = try context.fetch(fetchRequest)
            if let entities = results as? [CDJokeList] {
                for joke in entities {
                    let message = JokeModel.JokeCell(
                        cellIdentifier: StringConstants.cellIdentifiers.cellIdentifier,
                        text: joke.joke ?? "")
                    jokeData.insert(message, at: 0)
                }
            }
        } catch let error as NSError {
            print(error.debugDescription)
        }
        completionHandler(jokeData)
    }
}
