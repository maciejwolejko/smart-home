//
//  ViewController.swift
//  SmartHome
//
//  Created by MW on 06/03/2020.
//  Copyright © 2020 MW. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    let initObjects = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        initObjectsActions()
        autoLogIn()
    }
    
    override func loadView() {
        super.loadView()
        
        view = initObjects
    }
    
    func setupView() {
        
        view.backgroundColor = UIColor(red: 41/255, green: 40/255, blue: 102/255, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(red: 41/255, green: 40/255, blue: 102/255, alpha: 1)
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func initObjectsActions() {
        
        initObjects.newAccountButton.addTarget(self, action: #selector(newAccountButtonPressed), for: .touchUpInside)
        initObjects.loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        initObjects.newPasswordButton.addTarget(self, action: #selector(newPasswordButtonPressed), for: .touchUpInside)
    }
    
    func autoLogIn() {
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            if Auth.auth().currentUser != nil {
                self.navigationController?.pushViewController(TabBarViewController(), animated: true)
            }
        }
    }
    
    @objc private func loginButtonPressed() {
        
        guard let emailTextField = initObjects.emailTextField.text else { return }
        guard let passwordTextField = initObjects.passwordTextField.text else { return }

        if initObjects.emailTextField.text! == "" && initObjects.passwordTextField.text! == "" || initObjects.emailTextField.text! == "" || initObjects.passwordTextField.text! == "" {
            let alert = UIAlertController(title: "UWAGA!", message: "Niepoprawnie wprowadzono dane", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ponów!", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            Auth.auth().signIn(withEmail: emailTextField, password: passwordTextField) { (_, error) in
                if error != nil {
                    let alert = UIAlertController(title: "Warning!", message: "Email or password doesn't exist", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Repeat", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    self.navigationController?.pushViewController(TabBarViewController(), animated: true)
                    self.initObjects.emailTextField.text = ""
                    self.initObjects.passwordTextField.text = ""
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
