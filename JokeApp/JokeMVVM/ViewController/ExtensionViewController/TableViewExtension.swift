//
//  TableViewExtension.swift
//  JokeApp
//
//  Created by Ankit Yadav on 10/06/23.
//

import Foundation
import UIKit

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rootModel = viewModel.rootModel as? JokeModel.Root else { return 0 }
        return rootModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jokeTableViewCell", for: indexPath) as! JokeTableViewCell
        cell.backgroundColor = .systemTeal
        guard let rootModel = viewModel.rootModel as? JokeModel.Root else { return UITableViewCell() }
        let cellModel = rootModel.data[indexPath.row]
        cell.setData(data: cellModel.text)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

