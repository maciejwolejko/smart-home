//
//  CameraViewController.swift
//  SmartHome
//
//  Created by MW on 3/26/20.
//  Copyright © 2020 MW. All rights reserved.
//

import UIKit
import Firebase

class CameraViewController: UIViewController {

    private lazy var userNameButton: UIButton = {
        let bt = UIButton()
        bt.setTitleColor(.white, for: .normal)
        bt.titleLabel?.font = .systemFont(ofSize: 25)
        bt.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    private lazy var userButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "user")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(userAccountButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 41/255, green: 40/255, blue: 102/255, alpha: 1)
        
        setupObjects()
        
        displayUserName()
        
    }

    func displayUserName() {
        Database.database().reference().child("registeredUsers")
            .queryOrdered(byChild: "uid")
            .queryEqual(toValue: Auth.auth().currentUser?.uid)
            .observe(.childAdded) { (snapshot) in
                if let dictionary = snapshot.value as? [String: Any] {
                    let name = dictionary["name"] as? String
                    self.userNameButton.setTitle("Hi, \(name!)", for: .normal)
                }
        }
    }
        
    func setupObjects() {
        [userNameButton, userButton].forEach{view.addSubview($0)}
        
        userNameButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 20, bottom: 0, right: 0))
        
        userButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 20), size: .init(width: 45, height: 45))
        
    }
    
    @objc func userAccountButtonPressed() {
         print(1)
     }
    
    @objc func logoutButtonPressed() {
        do {
            try Auth.auth().signOut()
            navigationController?.pushViewController(LoginViewController(), animated: true)
        } catch let error {
            print(error)
        }
    }
    
}
