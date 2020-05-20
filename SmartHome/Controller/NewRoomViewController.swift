//
//  NewRoomViewController.swift
//  SmartHome
//
//  Created by MW on 06/03/2020.
//  Copyright © 2020 MW. All rights reserved.
//

import UIKit
import Firebase



class NewRoomViewController: UIViewController {
    
    let initObjects = NewRoomView()
    let reuseIdentifier = "reuseCell"
    let roomNames = ["Living Room", "Bathroom", "Bedroom", "Kitchen"]
    let roomImages = ["livingroom", "bathroom", "bedroom", "kitchen"]
    
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
        
        initObjects.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        initObjects.tableView.delegate = self
        initObjects.tableView.dataSource = self
        initObjects.tableView.register(ChooseRoomCell.self, forCellReuseIdentifier: reuseIdentifier)
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
