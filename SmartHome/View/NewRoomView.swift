//
//  NewRoomView.swift
//  SmartHome
//
//  Created by Maciej Wołejko on 20/05/2020.
//  Copyright © 2020 Maciej Wołejko. All rights reserved.
//

import UIKit

class NewRoomView: UIView {

    let screen = UIScreen.main.bounds
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        tableView.backgroundColor = UIColor(red: 41/255, green: 40/255, blue: 102/255, alpha: 1)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("< Back", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubViews() {
        
        [backButton, tableView].forEach { addSubview($0) }

        backButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 20, bottom: 0, right: 0))
        
        tableView.anchor(top: backButton.bottomAnchor, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10))
    }
}
