//
//  RePasswordView.swift
//  SmartHome
//
//  Created by Maciej Wołejko on 20/05/2020.
//  Copyright © 2020 Maciej Wołejko. All rights reserved.
//

import UIKit

class RePasswordView: UIView {

     let screen = UIScreen.main.bounds
    
     private lazy var logoImage: UIImageView = {
           let imageView = UIImageView()
           imageView.contentMode = .scaleAspectFit
           imageView.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
           imageView.tintColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)
           imageView.translatesAutoresizingMaskIntoConstraints = false
           return imageView
       }()
       
    private lazy var nameLabel: UILabel = {
           let label = UILabel()
           label.text = "Smart Home"
           label.font = .systemFont(ofSize: screen.height * 0.04)
           label.textColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
       
    private lazy var subNameLabel: UILabel = {
           let label = UILabel()
           label.text = "by mwsoftware"
           label.textAlignment = .center
           label.font = .systemFont(ofSize: screen.height * 0.02)
           label.textColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.textAlignment = .center
        textField.delegate = self
        textField.layer.borderColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1).cgColor
        textField.layer.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1).cgColor
        textField.attributedPlaceholder = .init(string: "jan.kowalski@gmail.com", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var sendNewPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send Password", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.backgroundColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1).cgColor
        button.layer.cornerRadius = 10
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
        
        [logoImage, nameLabel, subNameLabel, emailLabel, emailTextField, sendNewPasswordButton].forEach { addSubview($0) }

        logoImage.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: nameLabel.leadingAnchor, padding: .init(top: screen.height * 0.075, left: screen.width * 0.15, bottom: 0, right: screen.width * 0.015), size: .init(width: 0, height: screen.height * 0.1))
        
        nameLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: logoImage.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: screen.height * 0.095, left: screen.width * 0.015, bottom: 0, right: screen.width * 0.15), size: .init(width: 0, height: screen.height * 0.03))
        
        subNameLabel.anchor(top: nameLabel.bottomAnchor, leading: logoImage.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: screen.width * 0.015, bottom: 0, right: screen.width * 0.15), size: .init(width: 0, height: screen.height * 0.05))
        
        emailLabel.anchor(top: logoImage.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: screen.height * 0.08, left: screen.width * 0.075, bottom: 0, right: 0), size: .init(width: screen.width * 0.1, height: screen.height * 0.02))
               
        emailTextField.anchor(top: emailLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: screen.height * 0.005, left: screen.width * 0.075, bottom: 0, right: screen.width * 0.075), size: .init(width: 0, height: screen.height * 0.05))
        
         sendNewPasswordButton.anchor(top: emailTextField.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: screen.height * 0.045, left: screen.width * 0.075, bottom: 0, right: screen.width * 0.075), size: .init(width: 0, height: screen.height * 0.05))
    }
}

extension RePasswordView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        emailTextField.resignFirstResponder()
        return true
    }
}
