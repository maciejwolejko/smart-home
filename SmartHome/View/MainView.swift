//
//  MainView.swift
//  SmartHome
//
//  Created by Maciej Wołejko on 20/05/2020.
//  Copyright © 2020 Maciej Wołejko. All rights reserved.
//

import UIKit

class MainView: UIView {

    let screen = UIScreen.main.bounds
       
    lazy var userNameButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
       
    lazy var userButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "user")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
       
    private lazy var modeLabel: UILabel = {
        let label = UILabel()
        label.text = "Mode"
        label.textColor = .white
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
       
    private lazy var modeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [winterModeButton, springModeButton, summerModeButton, autumnModeButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = CGFloat(13)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
       
    lazy var winterModeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Winter", for: .normal)
        button.backgroundColor = UIColor(red: 55/255, green: 50/255, blue: 135/255, alpha: 1)
        return button
    }()
       
    lazy var springModeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Spring", for: .normal)
        button.backgroundColor = UIColor(red: 55/255, green: 50/255, blue: 135/255, alpha: 1)
        return button
    }()

    lazy var summerModeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Summer", for: .normal)
        button.backgroundColor = UIColor(red: 55/255, green: 50/255, blue: 135/255, alpha: 1)
        return button
    }()
       
    lazy var autumnModeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Autumn", for: .normal)
        button.backgroundColor = UIColor(red: 55/255, green: 50/255, blue: 135/255, alpha: 1)
        return button
    }()

    private lazy var roomLabel: UILabel = {
        let label = UILabel()
        label.text = "Room"
        label.textColor = .white
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var roomCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(red: 41/255, green: 40/255, blue: 102/255, alpha: 1)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
       
    lazy var addNewRoomButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addc")?.withRenderingMode(.alwaysOriginal), for: .normal)
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
        [userNameButton, userButton, modeLabel, modeStackView, roomLabel, roomCollectionView, addNewRoomButton].forEach { addSubview($0) }

        userNameButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 20, bottom: 0, right: 0))
        
        userButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 20), size: .init(width: 45, height: 45))
        
        modeLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: screen.height * 0.075, left: screen.width * 0.05, bottom: 0, right: 0), size: .init(width: 0, height: screen.height * 0.02))
            
        modeStackView.anchor(top: modeLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: screen.width * 0.05, bottom: 0, right: screen.width * 0.05), size: .init(width: 0, height: 50))
        
        roomLabel.anchor(top: modeStackView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: screen.height * 0.02, left: screen.width * 0.05, bottom: 0, right: 0), size: .init(width: 0, height: screen.height * 0.02))
        
        roomCollectionView.anchor(top: roomLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 70, right: 10))

        addNewRoomButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: screen.height * 0.76, left: 0, bottom: 0, right: screen.width * 0.01), size: .init(width: screen.width * 0.2, height: screen.height * 0.1))
    }
}
