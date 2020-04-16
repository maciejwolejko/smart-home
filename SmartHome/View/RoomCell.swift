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
        let ir = UIImageView(image: UIImage(named: ""))
        ir.translatesAutoresizingMaskIntoConstraints = false
        return ir
    }()
    
    lazy var nameRoom: UILabel = {
        let nr = UILabel()
        nr.textColor = .white
        nr.font = .systemFont(ofSize: screen.width * 0.07)
        nr.translatesAutoresizingMaskIntoConstraints = false
        return nr
    }()
    
    lazy var deviceNumber: UILabel = {
        let dn = UILabel()
        dn.textColor = .gray
        dn.translatesAutoresizingMaskIntoConstraints = false
        return dn
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupObjects()
        iconRoom.tintColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)
        backgroundColor = UIColor(red: 55/255, green: 50/255, blue: 135/255, alpha: 1)
        
    }
    
    func setupObjects() {
        [iconRoom, nameRoom, deviceNumber].forEach{addSubview($0)}

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

