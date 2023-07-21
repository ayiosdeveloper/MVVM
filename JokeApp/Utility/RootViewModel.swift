//
//  RootViewModel.swift
//  JokeApp
//
//  Created by Ankit Yadav on 10/06/23.
//

import Foundation

protocol CellActionType { }
protocol RootModel { }
protocol RootRepository {}
protocol RootRepositoryCDEntity {}


protocol TableViewConstants {
    var reuseableIdentifier: String { get }
}

protocol RootTableViewCellModel {
    var cellIdentifier: String { get set }
    var cellType: CellActionType? { get set }
}

class RootViewModel {
    var rootModel: RootModel?
    var repository: RootRepository?
    init() {}
}

