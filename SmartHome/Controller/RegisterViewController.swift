//
//  RegisterViewController.swift
//  SmartHome
//
//  Created by Maciej Wołejko on 06/03/2020.
//  Copyright © 2020 Maciej Wołejko. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController, UITextFieldDelegate {

    let screen = UIScreen.main.bounds
    
    lazy var backButton: UIButton = {
        let bb = UIButton()
        bb.setTitle("Already have an account? Sign in!", for: .normal)
        bb.setTitleColor(UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1), for: .normal)
        bb.titleLabel?.font = .systemFont(ofSize: 15)
        bb.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        bb.translatesAutoresizingMaskIntoConstraints = false
        return bb
    }()
    
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
    
    lazy var nameStringLabel: UILabel = {
        let el = UILabel()
        el.text = "Name"
        el.textAlignment = .left
        el.textColor = .white
        el.font = .systemFont(ofSize: 13)
        el.translatesAutoresizingMaskIntoConstraints = false
        return el
    }()
    
    lazy var nameTextField: UITextField = {
        let et = UITextField()
        et.layer.borderWidth = 1
        et.layer.cornerRadius = 10
        et.textAlignment = .center
        et.textColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)
        et.delegate = self
        et.layer.borderColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1).cgColor
        et.layer.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1).cgColor
        et.attributedPlaceholder = .init(string: "nickname", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)])
        et.autocorrectionType = .no
        et.translatesAutoresizingMaskIntoConstraints = false
        return et
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
    
    lazy var emailTextField: UITextField = {
        let et = UITextField()
        et.layer.borderWidth = 1
        et.layer.cornerRadius = 10
        et.textAlignment = .center
        et.textColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)
        et.delegate = self
        et.layer.borderColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1).cgColor
        et.layer.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1).cgColor
        et.attributedPlaceholder = .init(string: "jan.kowalski@gmail.com", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)])
        et.autocorrectionType = .no
        et.translatesAutoresizingMaskIntoConstraints = false
        return et
    }()
    
    lazy var passwordLabel: UILabel = {
        let pl = UILabel()
        pl.text = "Password"
        pl.textAlignment = .left
        pl.textColor = .white
        pl.font = .systemFont(ofSize: 13)
        pl.translatesAutoresizingMaskIntoConstraints = false
        return pl
    }()
    
    lazy var passwordTextField: UITextField = {
        let pt = UITextField()
        pt.layer.borderWidth = 1
        pt.layer.cornerRadius = 10
        pt.textAlignment = .center
        pt.textColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)
        pt.delegate = self
        pt.isSecureTextEntry = true
        pt.layer.borderColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1).cgColor
        pt.layer.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1).cgColor
        pt.attributedPlaceholder = .init(string: "****************", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)])
        pt.autocorrectionType = .no
        pt.translatesAutoresizingMaskIntoConstraints = false
        return pt
    }()
    
    lazy var rePasswordLabel: UILabel = {
        let rp = UILabel()
        rp.text = "Replace Password"
        rp.textAlignment = .left
        rp.textColor = .white
        rp.font = .systemFont(ofSize: 13)
        rp.translatesAutoresizingMaskIntoConstraints = false
        return rp
    }()
    
    lazy var rePasswordTextField: UITextField = {
        let rt = UITextField()
        rt.layer.borderWidth = 1
        rt.layer.cornerRadius = 10
        rt.textAlignment = .center
        rt.textColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)
        rt.delegate = self
        rt.isSecureTextEntry = true
        rt.layer.borderColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1).cgColor
        rt.layer.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1).cgColor
        rt.attributedPlaceholder = .init(string: "****************", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)])
        rt.autocorrectionType = .no
        rt.translatesAutoresizingMaskIntoConstraints = false
        return rt
    }()
    
    lazy var registerButton: UIButton = {
        let lb = UIButton(type: .system)
        lb.setTitle("Sign up", for: .normal)
        lb.setTitleColor(.white, for: .normal)
        lb.layer.cornerRadius = 10
        lb.layer.backgroundColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1).cgColor
        lb.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
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

    // MARK: - ButtonPressed Functions
    @objc private func registerButtonPressed() {
        if passwordTextField.text != rePasswordTextField.text! {
            let alert = UIAlertController(title: "Error!", message: "Passwords are not the same!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Repeat", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                
                if error != nil {
                    print(error!)
                    let alert = UIAlertController(title: "Error!", message: "The Email address is already in use!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Reply", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: "Registration Successful", message: "You can now log in to your account!", preferredStyle: .alert)
                    
                    let ref = Database.database().reference().child("registeredUsers").childByAutoId()
                    let values = ["name": self.nameTextField.text, "email": self.emailTextField.text, "uid": Auth.auth().currentUser?.uid]
                    ref.updateChildValues(values)
                    
                    //moze uzyc tu RxSwift? Bo sie bedziemy cofac i to bylby dobry pomysl...
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.navigationController?.pushViewController(LoginViewController(), animated: true)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc private func backButtonPressed() {
        print(2)
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
        func setupObjects() {

        [backButton, logoImage, nameLabel, subNameLabel, nameStringLabel, nameTextField, emailLabel, emailTextField, passwordLabel, passwordTextField, rePasswordLabel, rePasswordTextField, registerButton].forEach( {view.addSubview($0)})
        
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: screen.height * 0.02, left: 0, bottom: 0, right: screen.width * 0.04), size: .init(width: 0, height: screen.height * 0.05))
            
        logoImage.anchor(top: backButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nameLabel.leadingAnchor, padding: .init(top: screen.height * 0.075, left: screen.width * 0.15, bottom: 0, right: screen.width * 0.015), size: .init(width: 0, height: screen.height * 0.1))
        
        nameLabel.anchor(top: backButton.bottomAnchor, leading: logoImage.trailingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: screen.height * 0.095, left: screen.width * 0.015, bottom: 0, right: screen.width * 0.15), size: .init(width: 0, height: screen.height * 0.03))
        
        subNameLabel.anchor(top: nameLabel.bottomAnchor, leading: logoImage.trailingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: screen.width * 0.015, bottom: 0, right: screen.width * 0.15), size: .init(width: 0, height: screen.height * 0.05))
            
        nameStringLabel.anchor(top: logoImage.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: screen.height * 0.08, left: screen.width * 0.075, bottom: 0, right: 0), size: .init(width: screen.width * 0.1, height: screen.height * 0.02))
        
        nameTextField.anchor(top: nameStringLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: screen.height * 0.005, left: screen.width * 0.075, bottom: 0, right: screen.width * 0.075), size: .init(width: 0, height: screen.height * 0.05))
            
        emailLabel.anchor(top: nameTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: screen.height * 0.025, left: screen.width * 0.075, bottom: 0, right: 0), size: .init(width: screen.width * 0.1, height: screen.height * 0.02))
        
        emailTextField.anchor(top: emailLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: screen.height * 0.005, left: screen.width * 0.075, bottom: 0, right: screen.width * 0.075), size: .init(width: 0, height: screen.height * 0.05))
        
        passwordLabel.anchor(top: emailTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: screen.height * 0.025, left: screen.width * 0.075, bottom: 0, right: 0), size: .init(width: screen.width * 0.5, height: screen.height * 0.02))
        
        passwordTextField.anchor(top: passwordLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: screen.height * 0.005, left: screen.width * 0.075, bottom: 0, right: screen.width * 0.075), size: .init(width: 0, height: screen.height * 0.05))
        
        rePasswordLabel.anchor(top: passwordTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: screen.height * 0.025, left: screen.width * 0.075, bottom: 0, right: 0), size: .init(width: screen.width * 0.5, height: screen.height * 0.02))
        
        rePasswordTextField.anchor(top: rePasswordLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: screen.height * 0.005, left: screen.width * 0.075, bottom: 0, right: screen.width * 0.075), size: .init(width: 0, height: screen.height * 0.05))
        
        registerButton.anchor(top: rePasswordTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: screen.height * 0.045, left: screen.width * 0.075, bottom: 0, right: screen.width * 0.075), size: .init(width: 0, height: screen.height * 0.05))

    }
       
    // MARK: - TextField Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        rePasswordTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

