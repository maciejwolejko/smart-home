//
//  RoomViewController.swift
//  SmartHome
//
//  Created by MW on 3/26/20.
//  Copyright © 2020 MW. All rights reserved.
//

import UIKit
import Firebase

class RoomViewController: UIViewController {

    var roomId = ""
    let initObjects = RoomView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 41/255, green: 40/255, blue: 102/255, alpha: 1)
        initObjectsActions()
    }
    
    override func loadView() {
        super.loadView()
        
        view = initObjects
    }
       
    func initObjectsActions() {
        
        initObjects.userNameButton.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        initObjects.userButton.addTarget(self, action: #selector(userAccountButtonPressed), for: .touchUpInside)
        initObjects.deleteButton.addTarget(self, action: #selector(deleteCellButtonPressed), for: .touchUpInside)
    }
    
    @objc func deleteCellButtonPressed() {
        
        let alert = UIAlertController(title: "Czy na pewno chcesz usunac ten pokoj?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tak", style: .default, handler: { (_) in
            FirebaseService.shared.reference(to: .user)
                .child(Auth.auth()
                .currentUser!.uid)
                .child(self.roomId).removeValue()
        
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.navigationController?.pushViewController(TabBarViewController(), animated: true)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Nie", style: .cancel, handler: { (_) in

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.navigationController?.pushViewController(TabBarViewController(), animated: true)
            }
        }))
        
        present(alert, animated: true)
    }
       
    @objc func userAccountButtonPressed() {
        
        navigationController?.pushViewController(TabBarViewController(), animated: true)
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
