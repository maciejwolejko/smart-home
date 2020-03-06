//
//  ChooseRoomCell.swift
//  SmartHome
//
//  Created by Maciej Wołejko on 06/03/2020.
//  Copyright © 2020 Maciej Wołejko. All rights reserved.
//

import UIKit

class ChooseRoomCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1)
        textLabel?.textColor = .white
        detailTextLabel?.textColor = .gray
        imageView?.tintColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
