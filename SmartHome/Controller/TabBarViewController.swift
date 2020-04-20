//
//  TestViewController.swift
//  SmartHome
//
//  Created by user164182 on 3/25/20.
//  Copyright © 2020 Maciej Wołejko. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    let screen = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    func setupTabBar() {
        tabBar.layer.masksToBounds = true
        tabBar.layer.cornerRadius = 20
        tabBar.tintColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)
        tabBar.barTintColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(red: 53/255, green: 42/255, blue: 129/255, alpha: 1)
        
        let firstViewController = MainViewController()
        firstViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home2"), tag: 0)
        firstViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        firstViewController.tabBarItem.titlePositionAdjustment = .init(horizontal: 0, vertical: 10)
        
        let secondViewController = CameraViewController()
        secondViewController.tabBarItem = UITabBarItem(title: "Camera", image: UIImage(named: "camera"), tag: 0)
        secondViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        secondViewController.tabBarItem.titlePositionAdjustment = .init(horizontal: 0, vertical: 10)
        
        let thirdViewController = ControlsViewController()
        thirdViewController.tabBarItem = UITabBarItem(title: "Controls", image: UIImage(named: "controls"), tag: 0)
        thirdViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        thirdViewController.tabBarItem.titlePositionAdjustment = .init(horizontal: 0, vertical: 10)
        
        let fourthViewController = AnalyticViewController()
        fourthViewController.tabBarItem = UITabBarItem(title: "Analytic", image: UIImage(named: "analytics"), tag: 0)
        fourthViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        fourthViewController.tabBarItem.titlePositionAdjustment = .init(horizontal: 0, vertical: 10)
        
        viewControllers = [firstViewController, secondViewController, thirdViewController, fourthViewController]
    }
}
