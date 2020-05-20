//
//  AnalyticView.swift
//  SmartHome
//
//  Created by Maciej Wołejko on 20/05/2020.
//  Copyright © 2020 Maciej Wołejko. All rights reserved.
//

import UIKit

class AnalyticView: UIView {

    let screen = UIScreen.main.bounds
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    
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
    
    lazy var daysCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var chartCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var line: UIView = {
        let line = UIView(frame: .zero)
        line.backgroundColor = .gray
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    private lazy var horizontalBar: UIView = {
        let line = UIView(frame: .zero)
        line.backgroundColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        horizontalBarLeftAnchorConstraint?.constant = 111.33
        createSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubViews() {
        
           [userNameButton, userButton, daysCollectionView, line, horizontalBar, chartCollectionView].forEach { addSubview($0) }

           userNameButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 20, bottom: 0, right: 0))
           
           userButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 20), size: .init(width: 45, height: 45))
           
           daysCollectionView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 100, left: 40, bottom: 0, right: 40), size: .init(width: 0, height: 50))
           
           line.anchor(top: daysCollectionView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 2.5, left: 10, bottom: 0, right: 10), size: .init(width: 0, height: 1))
           
           horizontalBarLeftAnchorConstraint = horizontalBar.leftAnchor.constraint(equalTo: daysCollectionView.leftAnchor)
           horizontalBarLeftAnchorConstraint?.isActive = true
           
           NSLayoutConstraint.activate([
               horizontalBar.bottomAnchor.constraint(equalTo: daysCollectionView.bottomAnchor, constant: 2.5),
               horizontalBar.widthAnchor.constraint(equalTo: daysCollectionView.widthAnchor, multiplier: 1/3),
               horizontalBar.heightAnchor.constraint(equalToConstant: 1)
           ])
           
           chartCollectionView.anchor(top: line.bottomAnchor, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 40, bottom: 0, right: 40))
       }
}
