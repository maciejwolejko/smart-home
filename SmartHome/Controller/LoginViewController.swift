//
//  ViewController.swift
//  SmartHome
//
//  Created by MW on 06/03/2020.
//  Copyright © 2020 MW. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {

    let screen = UIScreen.main.bounds
    
    private lazy var newAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("New Account? Sign up!", for: .normal)
        button.setTitleColor(UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(newAccountButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var logoImage: UIImageView = {
        let li = UIImageView()
        li.contentMode = .scaleAspectFit
        li.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        li.tintColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)
        li.translatesAutoresizingMaskIntoConstraints = false
        return li
    }()
    
    private lazy var nameLabel: UILabel = {
        let nl = UILabel()
        nl.text = "Smart Home"
        nl.font = .systemFont(ofSize: screen.height * 0.04)
        nl.textColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)
        nl.translatesAutoresizingMaskIntoConstraints = false
        return nl
    }()
    
    private lazy var subNameLabel: UILabel = {
        let sn = UILabel()
        sn.text = "by mwsoftware"
        sn.textAlignment = .center
        sn.font = .systemFont(ofSize: screen.height * 0.02)
        sn.textColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)
        sn.translatesAutoresizingMaskIntoConstraints = false
        return sn
    }()
    
    private lazy var emailLabel: UILabel = {
        let el = UILabel()
        el.text = "Email"
        el.textAlignment = .left
        el.font = .systemFont(ofSize: 13)
        el.textColor = .white
        el.translatesAutoresizingMaskIntoConstraints = false
        return el
    }()
    
    private lazy var emailTextField: UITextField = {
        let et = UITextField()
        et.layer.borderWidth = 1
        et.layer.cornerRadius = 10
        et.layer.borderColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1).cgColor
        et.layer.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1).cgColor
        et.attributedPlaceholder = .init(string: "jan.kowalski@gmail.com", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)])
        et.textAlignment = .center
        et.textColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)
        et.delegate = self
        et.translatesAutoresizingMaskIntoConstraints = false
        return et
    }()
    
    private lazy var passwordLabel: UILabel = {
        let pl = UILabel()
        pl.text = "Password"
        pl.textAlignment = .left
        pl.font = .systemFont(ofSize: 13)
        pl.textColor = .white
        pl.translatesAutoresizingMaskIntoConstraints = false
        return pl
    }()
    
    private lazy var passwordTextField: UITextField = {
        let pt = UITextField()
        pt.layer.borderWidth = 1
        pt.layer.cornerRadius = 10
        pt.layer.borderColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1).cgColor
        pt.layer.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1).cgColor
        pt.attributedPlaceholder = .init(string: "****************", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)])
        pt.textAlignment = .center
        pt.textColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)
        pt.delegate = self
        pt.isSecureTextEntry = true
        pt.translatesAutoresizingMaskIntoConstraints = false
        return pt
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.backgroundColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1).cgColor
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var newPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Did you forget your password?", for: .normal)
        button.setTitleColor(UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(newPasswordButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 41/255, green: 40/255, blue: 102/255, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(red: 41/255, green: 40/255, blue: 102/255, alpha: 1)
        navigationItem.setHidesBackButton(true, animated: true)
        setupObjects()
        autoLogIn()

    }
    
    func autoLogIn() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            if Auth.auth().currentUser != nil {
                self.navigationController?.pushViewController(TabBarViewController(), animated: true)
            }
        }
    }
    
    @objc private func loginButtonPressed() {
        if emailTextField.text! == "" && passwordTextField.text! == "" || emailTextField.text! == "" || passwordTextField.text! == "" {
            let alert = UIAlertController(title: "UWAGA!", message: "Niepoprawnie wprowadzono dane", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ponów!", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                
                if error != nil {
                    let alert = UIAlertController(title: "Warning!", message: "Email or password doesn't exist", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Repeat", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    self.navigationController?.pushViewController(TabBarViewController(), animated: true)
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                }
            }
        }
    }
    
    @objc private func newPasswordButtonPressed() {
        navigationController?.pushViewController(RePasswordViewController(), animated: true)
    }
    
    @objc private func newAccountButtonPressed() {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    func setupObjects() {

        [newAccountButton, logoImage, nameLabel, subNameLabel, emailLabel, emailTextField, passwordLabel, passwordTextField, loginButton, newPasswordButton].forEach{view.addSubview($0)}
        
        newAccountButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: screen.height * 0.02, left: 0, bottom: 0, right: screen.width * 0.04), size: .init(width: 0, height: screen.height * 0.05))
        
        logoImage.anchor(top: newAccountButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nameLabel.leadingAnchor, padding: .init(top: screen.height * 0.075, left: screen.width * 0.15, bottom: 0, right: screen.width * 0.015), size: .init(width: 0, height: screen.height * 0.1))
        
        nameLabel.anchor(top: newAccountButton.bottomAnchor, leading: logoImage.trailingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: screen.height * 0.095, left: screen.width * 0.015, bottom: 0, right: screen.width * 0.15), size: .init(width: 0, height: screen.height * 0.03))
        
        subNameLabel.anchor(top: nameLabel.bottomAnchor, leading: logoImage.trailingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: screen.width * 0.015, bottom: 0, right: screen.width * 0.15), size: .init(width: 0, height: screen.height * 0.05))
        
        emailLabel.anchor(top: logoImage.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: screen.height * 0.13, left: screen.width * 0.075, bottom: 0, right: 0), size: .init(width: screen.width * 0.1, height: screen.height * 0.02))
        
        emailTextField.anchor(top: emailLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: screen.height * 0.005, left: screen.width * 0.075, bottom: 0, right: screen.width * 0.075), size: .init(width: 0, height: screen.height * 0.05))
        
        passwordLabel.anchor(top: emailTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: screen.height * 0.025, left: screen.width * 0.075, bottom: 0, right: 0), size: .init(width: screen.width * 0.5, height: screen.height * 0.02))
        
        passwordTextField.anchor(top: passwordLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: screen.height * 0.005, left: screen.width * 0.075, bottom: 0, right: screen.width * 0.075), size: .init(width: 0, height: screen.height * 0.05))
        
        loginButton.anchor(top: passwordTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: screen.height * 0.045, left: screen.width * 0.075, bottom: 0, right: screen.width * 0.075), size: .init(width: 0, height: screen.height * 0.05))
        
        newPasswordButton.anchor(top: loginButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: screen.height * 0.175, left: screen.width * 0.075, bottom: 0, right: screen.width * 0.075), size: .init(width: 0, height: screen.height * 0.05))
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         emailTextField.resignFirstResponder()
         passwordTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
