//
//  NewRoomViewController.swift
//  SmartHome
//
//  Created by Maciej Wołejko on 06/03/2020.
//  Copyright © 2020 Maciej Wołejko. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "reuseCell"

class NewRoomViewController: UIViewController {
    
    let roomNames = ["Living Room", "Bathroom", "Bedroom", "Kitchen"]
    let roomImages = ["livingroom", "bathroom", "bedroom", "kitchen"]
    let screen = UIScreen.main.bounds
    
    lazy var tableView: UITableView = {
        let rt = UITableView()
        rt.separatorColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)
        rt.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        rt.delegate = self
        rt.dataSource = self
        rt.backgroundColor = UIColor(red: 41/255, green: 40/255, blue: 102/255, alpha: 1)
        rt.register(ChooseRoomCell.self, forCellReuseIdentifier: reuseIdentifier)
        rt.translatesAutoresizingMaskIntoConstraints = false
        return rt
    }()
    
    lazy var doneButton: UIButton = {
        let db = UIButton()
        return db
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 41/255, green: 40/255, blue: 102/255, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(red: 41/255, green: 40/255, blue: 102/255, alpha: 1)
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        
        setupObjects()
        
        print(view.frame.height)
    }
    
    func setupObjects() {
        
        [tableView].forEach({view.addSubview($0)})
        
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10))
    }
    
    @objc func doneButtonPressed() {
        navigationController?.pushViewController(MainViewController(), animated: true)
    }
}

extension NewRoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ChooseRoomCell
        cell.textLabel?.text = roomNames[indexPath.row]
        cell.detailTextLabel!.text = "Choose this room"
        cell.imageView!.image = UIImage(named: roomImages[indexPath.row])?.withRenderingMode(.alwaysTemplate)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = roomNames[indexPath.row]
        let image = roomImages[indexPath.row]
        let ref = Database.database().reference().child("User").child(Auth.auth().currentUser!.uid).childByAutoId()
        let values = ["name": name, "icon": image, "devicesNumber": ""] as [String : Any]
        ref.updateChildValues(values)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.navigationController?.pushViewController(MainViewController(), animated: true)
        }
    }
    
}

