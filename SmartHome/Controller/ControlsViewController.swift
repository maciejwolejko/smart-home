//
//  ControlsViewController.swift
//  SmartHome
//
//  Created by MW on 3/26/20.
//  Copyright © 2020 MW. All rights reserved.
//

import UIKit
import Firebase

class ControlsViewController: UIViewController {

    let initObjects = ControlsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 41/255, green: 40/255, blue: 102/255, alpha: 1)
        displayUserName()
        initObjectsActions()
    }
    
    override func loadView() {
        super.loadView()
        
        view = initObjects
    }
    
    func initObjectsActions() {
        
        initObjects.userNameButton.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        initObjects.userButton.addTarget(self, action: #selector(userAccountButtonPressed), for: .touchUpInside)
    }
    
    func displayUserName() {
        
        FirebaseService.shared.reference(to: .registeredUsers)
            .queryOrdered(byChild: "uid")
            .queryEqual(toValue: Auth.auth().currentUser?.uid)
            .observe(.childAdded) { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: Any] {
                    let name = dictionary["name"] as? String
                    self.initObjects.userNameButton.setTitle("Hi, \(name!)", for: .normal)
                }
        }
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
