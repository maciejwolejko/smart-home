//
//  MainViewController.swift
//  SmartHome
//
//  Created by MW on 06/03/2020.
//  Copyright © 2020 MW. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "reuseCell"

class MainViewController: UIViewController {

    var rooms: [Room] = []
    let screen = UIScreen.main.bounds
    
    private lazy var userNameButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var userButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "user")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(userAccountButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var modeLabel: UILabel = {
        let label = UILabel()
        label.text = "Mode"
        label.textColor = .white
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var modeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [winterModeButton, springModeButton, summerModeButton, autumnModeButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = CGFloat(13)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var winterModeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Winter", for: .normal)
        button.addTarget(self, action: #selector(winterModeButtonPressed), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 55/255, green: 50/255, blue: 135/255, alpha: 1)
        return button
    }()
    
    private lazy var springModeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Spring", for: .normal)
        button.addTarget(self, action: #selector(springModeButtonPressed), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 55/255, green: 50/255, blue: 135/255, alpha: 1)
        return button
    }()

    private lazy var summerModeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Summer", for: .normal)
        button.addTarget(self, action: #selector(summerModeButtonPressed), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 55/255, green: 50/255, blue: 135/255, alpha: 1)
        return button
        
    }()
    
    private lazy var autumnModeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Autumn", for: .normal)
        button.addTarget(self, action: #selector(autumnModeButtonPressed), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 55/255, green: 50/255, blue: 135/255, alpha: 1)
        return button
    }()

    private lazy var roomLabel: UILabel = {
        let label = UILabel()
        label.text = "Room"
        label.textColor = .white
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var roomCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(red: 41/255, green: 40/255, blue: 102/255, alpha: 1)
        collectionView.register(RoomCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var addNewRoomButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(addNewRoomButtonPressed), for: .touchUpInside)
        button.setImage(UIImage(named: "addc")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 41/255, green: 40/255, blue: 102/255, alpha: 1)
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: userNameButton)
        setupObjects()
        view.bringSubviewToFront(addNewRoomButton)
        fetchingData()
        displayUserName()
    }
    
    func displayUserName() {
        FirebaseService.shared.reference(to: .registeredUsers)
            .queryOrdered(byChild: "uid")
            .queryEqual(toValue: Auth.auth().currentUser?.uid)
            .observe(.childAdded) { (snapshot) in
                if let dictionary = snapshot.value as? [String: Any] {
                    let name = dictionary["name"] as? String
                    self.userNameButton.setTitle("Hi, \(name!)", for: .normal)
                }
        }
    }
    
   @objc func userAccountButtonPressed() {
        print(1)
    }
    
    @objc func winterModeButtonPressed() {
        winterModeButton.backgroundColor = .systemPink
        springModeButton.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1)
        summerModeButton.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1)
        autumnModeButton.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1)
    }
    
    @objc func springModeButtonPressed() {
        winterModeButton.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1)
        springModeButton.backgroundColor = .systemPink
        summerModeButton.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1)
        autumnModeButton.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1)
        
    }
    
    @objc func summerModeButtonPressed() {
        winterModeButton.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1)
        springModeButton.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1)
        summerModeButton.backgroundColor = .systemPink
        autumnModeButton.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1)
        
    }
    
    @objc func autumnModeButtonPressed() {
        winterModeButton.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1)
        springModeButton.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1)
        summerModeButton.backgroundColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1)
        autumnModeButton.backgroundColor = .systemPink
        
    }

    func fetchingData() {
        FirebaseService.shared.reference(to: .User)
            .child(Auth.auth().currentUser!.uid)
            .observe(.childAdded) { (snapshot) in
            
                if let dictionary = snapshot.value as? [String: Any] {
                    var room = Room(icon: "", name: "", numberOfDevices: "")
                    room.name = dictionary["name"] as? String
                    room.icon = dictionary["icon"] as? String
                    room.id = dictionary["id"] as? String
                    self.rooms.append(room)
                
                    DispatchQueue.main.async {
                        self.roomCollectionView.reloadData()
                    }
                }
        }
    }
    
    func setupObjects() {
        [userNameButton, userButton, modeLabel, modeStackView, roomLabel, roomCollectionView, addNewRoomButton].forEach{view.addSubview($0)}
        
        userNameButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 20, bottom: 0, right: 0))
        
        userButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 20), size: .init(width: 45, height: 45))
        
        modeLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: screen.height * 0.075, left: screen.width * 0.05, bottom: 0, right: 0), size: .init(width: 0, height: screen.height * 0.02))
            
        modeStackView.anchor(top: modeLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: screen.width * 0.05, bottom: 0, right: screen.width * 0.05), size: .init(width: 0, height: 50))
        
        roomLabel.anchor(top: modeStackView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: screen.height * 0.02, left: screen.width * 0.05, bottom: 0, right: 0), size: .init(width: 0, height: screen.height * 0.02))
        
        roomCollectionView.anchor(top: roomLabel.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 70, right: 10))
        
        addNewRoomButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: screen.height * 0.76, left: 0, bottom: 0, right: screen.width * 0.01), size: .init(width: screen.width * 0.2, height: screen.height * 0.1))
    
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
        
        guard let cell = roomCollectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? RoomCell else { return UICollectionViewCell() }
        
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
        let vc = RoomViewController()
        guard let name = room.name else { return }
        guard let id = room.id else { return }
        vc.roomNameLabel.text = "\(name)"
        vc.roomId = id
        navigationController?.pushViewController(vc, animated: true)
    }
}
