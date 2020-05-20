//
//  RePasswordViewController.swift
//  SmartHome
//
//  Created by MW on 06/03/2020.
//  Copyright © 2020 MW. All rights reserved.
//

import UIKit

class RePasswordViewController: UIViewController {

    let initObjects = RePasswordView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 41/255, green: 40/255, blue: 102/255, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(red: 41/255, green: 40/255, blue: 102/255, alpha: 1)
        navigationItem.setHidesBackButton(true, animated: true)
        initObjectsActions()
     }
    
    override func loadView() {
        super.loadView()
        
        view = initObjects
    }
    
    func initObjectsActions() {
        initObjects.sendNewPasswordButton.addTarget(self, action: #selector(sendNewPasswordButtonPressed), for: .touchUpInside)
    }
    
    @objc private func sendNewPasswordButtonPressed() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
