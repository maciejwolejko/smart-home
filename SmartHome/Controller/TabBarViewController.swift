//
//  TestViewController.swift
//  SmartHome
//
//  Created by user164182 on 3/25/20.
//  Copyright © 2020 Maciej Wołejko. All rights reserved.
//

import UIKit

class TestViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        let firstViewController = MainViewController()
        firstViewController.tabBarItem = UITabBarItem(title: "HOME", image: UIImage(named: "home"), tag: 0)
        let secondViewController = NewRoomViewController()
        secondViewController.tabBarItem = UITabBarItem(title: "New", image: UIImage(named: "home"), tag: 0)
        viewControllers = [firstViewController, secondViewController]
               //firstViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home")?.withRenderingMode(.alwaysTemplate), selectedImage: UIImage(named: "home")?.withRenderingMode(.alwaysOriginal))
        //let items = [firstViewController]
       // tabBarController?.viewControllers = items
      //tabBarController?.moreNavigationController.viewControllers = [firstViewController]
       // tabBarController?.customizableViewControllers = [firstViewController]
       //tabBarItem.badgeColor = .black

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
