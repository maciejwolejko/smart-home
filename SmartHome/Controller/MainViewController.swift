//
//  MainViewController.swift
//  SmartHome
//
//  Created by Maciej Wołejko on 06/03/2020.
//  Copyright © 2020 Maciej Wołejko. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "reuseCell"

class MainViewController: UIViewController {

    var rooms: [Room] = []
    let screen = UIScreen.main.bounds
    var number = ""
    
    lazy var leftBarButtonItem: UIButton = {
        let bt = UIButton()
        bt.setTitle("Hi, Maciej", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        //bt.isEnabled = false
        return bt
    }()
    
    lazy var roomLabel: UILabel = {
        let rl = UILabel()
        rl.text = "Room"
        rl.textColor = .white
        rl.font = .systemFont(ofSize: 13)
        rl.translatesAutoresizingMaskIntoConstraints = false
        return rl
    }()
    
    lazy var roomCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let rc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        rc.backgroundColor = UIColor(red: 41/255, green: 40/255, blue: 102/255, alpha: 1)
        rc.register(RoomCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        rc.delegate = self
        rc.dataSource = self
        rc.translatesAutoresizingMaskIntoConstraints = false
        return rc
    }()
    
    lazy var addNewRoomButton: UIButton = {
        let ab = UIButton()
        ab.addTarget(self, action: #selector(addNewRoomButtonPressed), for: .touchUpInside)
        ab.setImage(UIImage(named: "addc")?.withRenderingMode(.alwaysOriginal), for: .normal)
        ab.translatesAutoresizingMaskIntoConstraints = false
        return ab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 41/255, green: 40/255, blue: 102/255, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(red: 41/255, green: 40/255, blue: 102/255, alpha: 1)
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButtonItem)

        setupObjects()
        
        view.bringSubviewToFront(addNewRoomButton)
        
        fetchingData()
    }
    
    func fetchingData() {

        Database.database().reference().child("User").child(Auth.auth().currentUser!.uid)
        .observe(.childAdded) { (snapshot) in
            if let dictionary = snapshot.value as? [String: Any] {
                var room = Room(icon: "", name: "", numberOfDevices: "")
                room.name = dictionary["name"] as? String
                room.icon = dictionary["icon"] as? String
                self.rooms.append(room)
                DispatchQueue.main.async {
                    self.roomCollectionView.reloadData()
                }
            }
        }
    }
    
    func setupObjects() {
        [roomLabel, roomCollectionView, addNewRoomButton].forEach({view.addSubview($0)})
        
        roomLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: screen.height * 0.02, left: screen.width * 0.05, bottom: 0, right: 0), size: .init(width: 0, height: screen.height * 0.02))
        
        roomCollectionView.anchor(top: roomLabel.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        
        addNewRoomButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: screen.height * 0.7, left: 0, bottom: 0, right: screen.width * 0.1), size: .init(width: screen.width * 0.2, height: screen.height * 0.1))
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
        let cell = roomCollectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RoomCell
        
        let room = rooms[indexPath.row]
        cell.room = room
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screen.width * 0.9, height: screen.height * 0.15)
    }

}
