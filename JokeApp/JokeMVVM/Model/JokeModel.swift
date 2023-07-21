//
//  JokeModel.swift
//  JokeApp
//
//  Created by Ankit Yadav on 10/06/23.
//

import Foundation

struct JokeModel {
    struct Root: RootModel {
        
        var data: [JokeCell]
        
        mutating func update(value: [JokeCell]) {
            self.data = value
        }
        
        mutating func update(value: JokeCell) {
            self.data.append(value)
        }
        
        mutating func delete() {
            self.data.remove(at: 0)
        }
    }
    
    struct JokeCell: RootTableViewCellModel {
        var cellIdentifier: String
        var cellType: CellActionType?
        var text: String
    }
}
