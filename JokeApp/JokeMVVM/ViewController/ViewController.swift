//
//  ViewController.swift
//  JokeApp
//
//  Created by Ankit Yadav on 10/06/23.
//

import UIKit

class ViewController: UIViewController {
    
    let jokeTableView = UITableView()
    var viewModel = JokeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        jokeTableView.backgroundColor = .systemTeal
        jokeTableView.estimatedRowHeight = 300
        view.addSubview(jokeTableView)
        setUI()
        configureViewModel()
    }
    
    private func setUI() {
        jokeTableView.translatesAutoresizingMaskIntoConstraints = false
        jokeTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        jokeTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        jokeTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        jokeTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        jokeTableView.delegate = self
        jokeTableView.dataSource = self
        jokeTableView.register(JokeTableViewCell.self, forCellReuseIdentifier: "jokeTableViewCell")
        viewModel.rootModel = JokeModel.Root(data: [])
    }
    
    private func configureViewModel () {
        let repository = JokeRepository()
        repository.interactor = NetworkingCall()
        viewModel.repository = repository
        viewModel.configure()
        self.viewModel.bindJokeViewModelToController = { [weak self] in
            self?.updateDataSource()
        }
    }
    
    private func updateDataSource() {
        DispatchQueue.main.async { [weak self] in
            self?.jokeTableView.reloadData()
        }
    }
}
