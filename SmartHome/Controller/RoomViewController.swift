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
    
    private lazy var userNameButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("Hi, Maciej", for: .normal)
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
       
    lazy var roomNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "trash")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(deleteCellButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 41/255, green: 40/255, blue: 102/255, alpha: 1)
        setupObjects()
        
    }
       
    @objc func deleteCellButtonPressed() {
        let alert = UIAlertController(title: "Czy na pewno chcesz usunac ten pokoj?", message: "", preferredStyle: .alert)
       
        alert.addAction(UIAlertAction(title: "Tak", style: .default, handler: { (action) in
            Database.database().reference().child("User").child(Auth.auth().currentUser!.uid).child(self.roomId).removeValue()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.navigationController?.pushViewController(TabBarViewController(), animated: true)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Nie", style: .cancel, handler: { (action) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.navigationController?.pushViewController(TabBarViewController(), animated: true)
            }
        }))
        
        present(alert, animated: true)
    }
    
    func setupObjects() {
        [userNameButton, deleteButton, userButton, roomNameLabel].forEach{view.addSubview($0)}
           
        userNameButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 20, bottom: 0, right: 0))
        
        deleteButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 70), size: .init(width: 45, height: 45))
        
        userButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 20), size: .init(width: 45, height: 45))
        
        roomNameLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 100, left: 10, bottom: 0, right: 0))
        
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
