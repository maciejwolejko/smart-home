//
//  RegisterView.swift
//  SmartHome
//
//  Created by Maciej Wołejko on 20/05/2020.
//  Copyright © 2020 Maciej Wołejko. All rights reserved.
//

import UIKit

class RegisterView: UIView {

     let screen = UIScreen.main.bounds
     
     lazy var backButton: UIButton = {
         let button = UIButton()
         button.setTitle("Already have an account? Sign in!", for: .normal)
         button.setTitleColor(UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1), for: .normal)
         button.titleLabel?.font = .systemFont(ofSize: 15)
         button.translatesAutoresizingMaskIntoConstraints = false
         return button
    }()
     
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
     
     private lazy var nameStringLabel: UILabel = {
         let label = UILabel()
         label.text = "Name"
         label.textAlignment = .left
         label.textColor = .white
         label.font = .systemFont(ofSize: 13)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
     
     lazy var nameTextField: UITextField = {
         let textField = UITextField()
         textField.layer.borderWidth = 1
         textField.layer.cornerRadius = 10
         textField.textAlignment = .center
         textField.textColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)
         textField.delegate = self
         textField.layer.borderColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1).cgColor
         textField.layer.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1).cgColor
         textField.attributedPlaceholder = .init(string: "nickname", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)])
         textField.autocorrectionType = .no
         textField.translatesAutoresizingMaskIntoConstraints = false
         return textField
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
         textField.textColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)
         textField.delegate = self
         textField.layer.borderColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1).cgColor
         textField.layer.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1).cgColor
         textField.attributedPlaceholder = .init(string: "jan.kowalski@gmail.com", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)])
         textField.autocorrectionType = .no
         textField.translatesAutoresizingMaskIntoConstraints = false
         return textField
     }()
     
     private lazy var passwordLabel: UILabel = {
         let label = UILabel()
         label.text = "Password"
         label.textAlignment = .left
         label.textColor = .white
         label.font = .systemFont(ofSize: 13)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
     
     lazy var passwordTextField: UITextField = {
         let textField = UITextField()
         textField.layer.borderWidth = 1
         textField.layer.cornerRadius = 10
         textField.textAlignment = .center
         textField.textColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)
         textField.delegate = self
         textField.isSecureTextEntry = true
         textField.layer.borderColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1).cgColor
         textField.layer.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1).cgColor
         textField.attributedPlaceholder = .init(string: "****************", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)])
         textField.autocorrectionType = .no
         textField.translatesAutoresizingMaskIntoConstraints = false
         return textField
     }()
     
     private lazy var rePasswordLabel: UILabel = {
         let label = UILabel()
         label.text = "Replace Password"
         label.textAlignment = .left
         label.textColor = .white
         label.font = .systemFont(ofSize: 13)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
     
     lazy var rePasswordTextField: UITextField = {
         let textField = UITextField()
         textField.layer.borderWidth = 1
         textField.layer.cornerRadius = 10
         textField.textAlignment = .center
         textField.textColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)
         textField.delegate = self
         textField.isSecureTextEntry = true
         textField.layer.borderColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1).cgColor
         textField.layer.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1).cgColor
         textField.attributedPlaceholder = .init(string: "****************", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)])
         textField.autocorrectionType = .no
         textField.translatesAutoresizingMaskIntoConstraints = false
         return textField
     }()
     
     lazy var registerButton: UIButton = {
         let button = UIButton(type: .system)
         button.setTitle("Sign up", for: .normal)
         button.setTitleColor(.white, for: .normal)
         button.layer.cornerRadius = 10
         button.layer.backgroundColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1).cgColor
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
        
        [backButton, logoImage, nameLabel, subNameLabel, nameStringLabel, nameTextField, emailLabel, emailTextField, passwordLabel, passwordTextField, rePasswordLabel, rePasswordTextField, registerButton].forEach { addSubview($0) }
           
        backButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: screen.height * 0.02, left: 0, bottom: 0, right: screen.width * 0.04), size: .init(width: 0, height: screen.height * 0.05))
               
        logoImage.anchor(top: backButton.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nameLabel.leadingAnchor, padding: .init(top: screen.height * 0.075, left: screen.width * 0.15, bottom: 0, right: screen.width * 0.015), size: .init(width: 0, height: screen.height * 0.1))
           
        nameLabel.anchor(top: backButton.bottomAnchor, leading: logoImage.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: screen.height * 0.095, left: screen.width * 0.015, bottom: 0, right: screen.width * 0.15), size: .init(width: 0, height: screen.height * 0.03))
           
        subNameLabel.anchor(top: nameLabel.bottomAnchor, leading: logoImage.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: screen.width * 0.015, bottom: 0, right: screen.width * 0.15), size: .init(width: 0, height: screen.height * 0.05))
               
        nameStringLabel.anchor(top: logoImage.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: screen.height * 0.08, left: screen.width * 0.075, bottom: 0, right: 0), size: .init(width: screen.width * 0.1, height: screen.height * 0.02))
           
        nameTextField.anchor(top: nameStringLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: screen.height * 0.005, left: screen.width * 0.075, bottom: 0, right: screen.width * 0.075), size: .init(width: 0, height: screen.height * 0.05))
               
        emailLabel.anchor(top: nameTextField.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: screen.height * 0.025, left: screen.width * 0.075, bottom: 0, right: 0), size: .init(width: screen.width * 0.1, height: screen.height * 0.02))
           
        emailTextField.anchor(top: emailLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: screen.height * 0.005, left: screen.width * 0.075, bottom: 0, right: screen.width * 0.075), size: .init(width: 0, height: screen.height * 0.05))
           
        passwordLabel.anchor(top: emailTextField.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: screen.height * 0.025, left: screen.width * 0.075, bottom: 0, right: 0), size: .init(width: screen.width * 0.5, height: screen.height * 0.02))
           
        passwordTextField.anchor(top: passwordLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: screen.height * 0.005, left: screen.width * 0.075, bottom: 0, right: screen.width * 0.075), size: .init(width: 0, height: screen.height * 0.05))
           
        rePasswordLabel.anchor(top: passwordTextField.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: screen.height * 0.025, left: screen.width * 0.075, bottom: 0, right: 0), size: .init(width: screen.width * 0.5, height: screen.height * 0.02))
           
        rePasswordTextField.anchor(top: rePasswordLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: screen.height * 0.005, left: screen.width * 0.075, bottom: 0, right: screen.width * 0.075), size: .init(width: 0, height: screen.height * 0.05))
           
        registerButton.anchor(top: rePasswordTextField.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: screen.height * 0.045, left: screen.width * 0.075, bottom: 0, right: screen.width * 0.075), size: .init(width: 0, height: screen.height * 0.05))
       }
}

extension RegisterView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        rePasswordTextField.resignFirstResponder()
        return true
    }
}
