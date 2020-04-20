//
//  ChartCell.swift
//  SmartHome
//
//  Created by MW on 3/27/20.
//  Copyright © 2020 MW. All rights reserved.
//

import UIKit

class ChartCell: UICollectionViewCell {

    lazy var chartLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupObjects()
    }
    
    override var isHighlighted: Bool {
        didSet {
            chartLabel.textColor = isHighlighted ? UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1) : .white
        }
    }
    
    override var isSelected: Bool {
        didSet {
            chartLabel.textColor = isSelected ? UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1) : .white
        }
    }
    
    func setupObjects() {
        [chartLabel].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            chartLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            chartLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
