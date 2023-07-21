
//
//  JokeTableViewCell.swift
//  JokeApp
//
//  Created by Ankit Yadav on 10/06/23.
//

import UIKit

class JokeTableViewCell: UITableViewCell {
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    let jokeLabel:UILabel = {
        let label = UILabel()
        label.text = "What is Lorem Ipsum? What is Lorem Ipsum? What is Lorem Ipsum? What is Lorem Ipsum?"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        label.numberOfLines =  5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        containerView.addSubview(jokeLabel)
        containerView.backgroundColor = .systemMint
        self.contentView.addSubview(containerView)
        
        
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant:65).isActive = true
        
        jokeLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor ).isActive = true
        jokeLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        jokeLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
    }
    
    func setData(data: String) {
        jokeLabel.text = data
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
}
