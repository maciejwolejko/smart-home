//
//  RoomCell.swift
//  SmartHome
//
//  Created by MW on 06/03/2020.
//  Copyright © 2020 MW. All rights reserved.
//

import UIKit

class RoomCell: UICollectionViewCell {
    
    let screen = UIScreen.main.bounds
    
    lazy var iconRoom: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: ""))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nameRoom: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: screen.width * 0.07)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var deviceNumber: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupObjects()
        iconRoom.tintColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)
        backgroundColor = UIColor(red: 55/255, green: 50/255, blue: 135/255, alpha: 1)
        
    }
    
    func setupObjects() {
        [iconRoom, nameRoom, deviceNumber].forEach { addSubview($0) }

        NSLayoutConstraint.activate([
            nameRoom.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20),
            nameRoom.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 50),
            iconRoom.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconRoom.leftAnchor.constraint(equalTo: leftAnchor, constant: 50),
            deviceNumber.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20),
            deviceNumber.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 50)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
