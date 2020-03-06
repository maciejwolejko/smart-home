//
//  RePasswordViewController.swift
//  SmartHome
//
//  Created by Maciej Wołejko on 06/03/2020.
//  Copyright © 2020 Maciej Wołejko. All rights reserved.
//

import UIKit

class RePasswordViewController: UIViewController, UITextFieldDelegate {

    let screen = UIScreen.main.bounds
    
     lazy var logoImage: UIImageView = {
           let li = UIImageView()
           li.contentMode = .scaleAspectFit
           li.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
           li.tintColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)
           li.translatesAutoresizingMaskIntoConstraints = false
           return li
       }()
       
       lazy var nameLabel: UILabel = {
           let nl = UILabel()
           nl.text = "Smart Home"
           nl.font = .systemFont(ofSize: screen.height * 0.04)
           nl.textColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)
           nl.translatesAutoresizingMaskIntoConstraints = false
           return nl
       }()
       
       lazy var subNameLabel: UILabel = {
           let sn = UILabel()
           sn.text = "by mwsoftware"
           sn.textAlignment = .center
           sn.font = .systemFont(ofSize: screen.height * 0.02)
           sn.textColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)
           sn.translatesAutoresizingMaskIntoConstraints = false
           return sn
       }()
    
    lazy var emailLabel: UILabel = {
        let el = UILabel()
        el.text = "Email"
        el.textAlignment = .left
        el.textColor = .white
        el.font = .systemFont(ofSize: 13)
        el.translatesAutoresizingMaskIntoConstraints = false
        return el
    }()
    
    lazy var emailTextField : UITextField = {
        let et = UITextField()
        et.layer.borderWidth = 1
        et.layer.cornerRadius = 10
        et.textAlignment = .center
        et.delegate = self
        et.layer.borderColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1).cgColor
        et.layer.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1).cgColor
        et.attributedPlaceholder = .init(string: "jan.kowalski@gmail.com", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)])
        et.translatesAutoresizingMaskIntoConstraints = false
        return et
    }()
    
    lazy var sendNewPasswordButton : UIButton = {
        let lb = UIButton(type: .system)
        lb.setTitle("Send Password", for: .normal)
        lb.setTitleColor(.white, for: .normal)
        lb.layer.backgroundColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1).cgColor
        lb.layer.cornerRadius = 10
        lb.addTarget(self, action: #selector(sendNewPasswordButtonPressed), for: .touchUpInside)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
     override func viewDidLoad() {
         super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 41/255, green: 40/255, blue: 102/255, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(red: 41/255, green: 40/255, blue: 102/255, alpha: 1)
        navigationItem.setHidesBackButton(true, animated: true)
        
         setupObjects()
     }
    
     // MARK: - ButtonPressed Function
     @objc private func sendNewPasswordButtonPressed() {
         navigationController?.pushViewController(LoginViewController(), animated: true)
     }
     
    func setupObjects() {

        [logoImage, nameLabel, subNameLabel, emailLabel, emailTextField, sendNewPasswordButton].forEach({view.addSubview($0)})
        
        logoImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nameLabel.leadingAnchor, padding: .init(top: screen.height * 0.075, left: screen.width * 0.15, bottom: 0, right: screen.width * 0.015), size: .init(width: 0, height: screen.height * 0.1))
        
        nameLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: logoImage.trailingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: screen.height * 0.095, left: screen.width * 0.015, bottom: 0, right: screen.width * 0.15), size: .init(width: 0, height: screen.height * 0.03))
        
        subNameLabel.anchor(top: nameLabel.bottomAnchor, leading: logoImage.trailingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: screen.width * 0.015, bottom: 0, right: screen.width * 0.15), size: .init(width: 0, height: screen.height * 0.05))
        
        emailLabel.anchor(top: logoImage.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: screen.height * 0.08, left: screen.width * 0.075, bottom: 0, right: 0), size: .init(width: screen.width * 0.1, height: screen.height * 0.02))
               
        emailTextField.anchor(top: emailLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: screen.height * 0.005, left: screen.width * 0.075, bottom: 0, right: screen.width * 0.075), size: .init(width: 0, height: screen.height * 0.05))
        
         sendNewPasswordButton.anchor(top: emailTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: screen.height * 0.045, left: screen.width * 0.075, bottom: 0, right: screen.width * 0.075), size: .init(width: 0, height: screen.height * 0.05))
        
    }
    
    // MARK: - TextField Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
