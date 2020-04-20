//
//  NewRoomViewController.swift
//  SmartHome
//
//  Created by MW on 06/03/2020.
//  Copyright © 2020 MW. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "reuseCell"

class NewRoomViewController: UIViewController {
    
    let roomNames = ["Living Room", "Bathroom", "Bedroom", "Kitchen"]
    let roomImages = ["livingroom", "bathroom", "bedroom", "kitchen"]
    let screen = UIScreen.main.bounds
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(red: 41/255, green: 40/255, blue: 102/255, alpha: 1)
        tableView.register(ChooseRoomCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        button.setTitle("< Back", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 41/255, green: 40/255, blue: 102/255, alpha: 1)
        setupObjects()
    }
    
    func setupObjects() {
        
        [backButton, tableView].forEach { view.addSubview($0) }
        
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 20, bottom: 0, right: 0))
        
        tableView.anchor(top: backButton.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding:
            .init(top: 10, left: 10, bottom: 0, right: 10))
    }
    
    @objc func backButtonPressed() {
        navigationController?.pushViewController(TabBarViewController(), animated: true)
    }
    
}

extension NewRoomViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? ChooseRoomCell else { return UITableViewCell() }
        cell.textLabel?.text = roomNames[indexPath.row]
        cell.detailTextLabel!.text = "Choose this room"
        cell.imageView!.image = UIImage(named: roomImages[indexPath.row])?.withRenderingMode(.alwaysTemplate)
        return cell
        
    }
}

extension NewRoomViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = roomNames[indexPath.row]
        let image = roomImages[indexPath.row]
        let ref = FirebaseService.shared.reference(to: .user).child(Auth.auth().currentUser!.uid).childByAutoId()
        let values = ["name": name, "icon": image, "devicesNumber": "", "id": ref.key]
        ref.updateChildValues(values as [AnyHashable: Any])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.navigationController?.pushViewController(TabBarViewController(), animated: true)
        }
    }
}
