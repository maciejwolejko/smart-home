//
//  RegisterViewController.swift
//  SmartHome
//
//  Created by MW on 06/03/2020.
//  Copyright © 2020 MW. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    let initObjects = RegisterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupView()
        initObjectsActions()
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
        initObjects.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        initObjects.registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
    }

    @objc private func registerButtonPressed() {
        if initObjects.passwordTextField.text != initObjects.rePasswordTextField.text! {
            let alert = UIAlertController(title: "Error!", message: "Passwords are not the same!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Repeat", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            Auth.auth().createUser(withEmail: initObjects.emailTextField.text!, password: initObjects.passwordTextField.text!) { (_, error) in
                
                if error != nil {
                    print(error!)
                    let alert = UIAlertController(title: "Error!", message: "The Email address is already in use!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Reply", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: "Registration Successful", message: "You can now log in to your account!", preferredStyle: .alert)
                    let ref = FirebaseService.shared.reference(to: .registeredUsers).childByAutoId()
                    let values = ["name": self.initObjects.nameTextField.text, "email": self.initObjects.emailTextField.text, "uid": Auth.auth().currentUser?.uid]
                    ref.updateChildValues(values as [AnyHashable: Any])
                    
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.navigationController?.pushViewController(LoginViewController(), animated: true)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc private func backButtonPressed() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
}
