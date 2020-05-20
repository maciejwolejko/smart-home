//
//  MainViewController.swift
//  SmartHome
//
//  Created by MW on 06/03/2020.
//  Copyright © 2020 MW. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController {

    var rooms: [Room] = []
    let initObjects = MainView()
    let reuseIdentifier = "reuseCell"
    let screen = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 41/255, green: 40/255, blue: 102/255, alpha: 1)
        navigationItemSetup()
        view.bringSubviewToFront(initObjects.addNewRoomButton)
        initObjectsActions()
        fetchingData()
        displayUserName()
    }
    
    override func loadView() {
        super.loadView()
        
        view = initObjects
    }
    
    func initObjectsActions() {
        
        initObjects.userNameButton.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        initObjects.userButton.addTarget(self, action: #selector(userAccountButtonPressed), for: .touchUpInside)
        initObjects.winterModeButton.addTarget(self, action: #selector(winterModeButtonPressed), for: .touchUpInside)
        initObjects.springModeButton.addTarget(self, action: #selector(springModeButtonPressed), for: .touchUpInside)
        initObjects.summerModeButton.addTarget(self, action: #selector(summerModeButtonPressed), for: .touchUpInside)
        initObjects.autumnModeButton.addTarget(self, action: #selector(autumnModeButtonPressed), for: .touchUpInside)
        initObjects.roomCollectionView.register(RoomCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        initObjects.roomCollectionView.delegate = self
        initObjects.roomCollectionView.dataSource = self
        initObjects.addNewRoomButton.addTarget(self, action: #selector(addNewRoomButtonPressed), for: .touchUpInside)
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
    
    func navigationItemSetup() {
        
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: initObjects.userNameButton)
    }

   @objc func userAccountButtonPressed() {
    
        print(1)
    }
    
    @objc func winterModeButtonPressed() {
        
        initObjects.winterModeButton.backgroundColor = .systemPink
        initObjects.springModeButton.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1)
        initObjects.summerModeButton.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1)
        initObjects.autumnModeButton.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1)
    }
    
    @objc func springModeButtonPressed() {
        
        initObjects.winterModeButton.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1)
        initObjects.springModeButton.backgroundColor = .systemPink
        initObjects.summerModeButton.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1)
        initObjects.autumnModeButton.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1)
    }
    
    @objc func summerModeButtonPressed() {
        
        initObjects.winterModeButton.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1)
        initObjects.springModeButton.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1)
        initObjects.summerModeButton.backgroundColor = .systemPink
        initObjects.autumnModeButton.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1)
    }
    
    @objc func autumnModeButtonPressed() {
        
        initObjects.winterModeButton.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1)
        initObjects.springModeButton.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1)
        initObjects.summerModeButton.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1)
        initObjects.autumnModeButton.backgroundColor = .systemPink
    }

    func fetchingData() {
        
        FirebaseService.shared.reference(to: .user)
            .child(Auth.auth().currentUser!.uid)
            .observe(.childAdded) { (snapshot) in
            
                if let dictionary = snapshot.value as? [String: Any] {
                    var room = Room(icon: "", name: "", numberOfDevices: "")
                    room.name = dictionary["name"] as? String
                    room.icon = dictionary["icon"] as? String
                    room.uid = dictionary["id"] as? String

                    self.rooms.append(room)
                
                    DispatchQueue.main.async {
                        self.initObjects.roomCollectionView.reloadData()
                    }
                }
        }
    }
    
    @objc func addNewRoomButtonPressed() {
        
        navigationController?.pushViewController(NewRoomViewController(), animated: true)
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

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return rooms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = initObjects.roomCollectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? RoomCell else { return UICollectionViewCell() }
        
        let room = rooms[indexPath.row]
        cell.nameRoom.text = room.name
        cell.deviceNumber.text = "No device added!"
        cell.iconRoom.image = UIImage(named: room.icon!)?.withRenderingMode(.alwaysTemplate)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: screen.width * 0.9, height: screen.height * 0.15)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let room = self.rooms[indexPath.row]
        guard let name = room.name else { return }
        guard let uid = room.uid else { return }
        
        let view = RoomViewController()
        view.initObjects.roomNameLabel.text = "\(name)"
        view.roomId = uid
        navigationController?.pushViewController(view, animated: true)

    }
}
