//
//  AnalyticViewController.swift
//  SmartHome
//
//  Created by MW on 3/26/20.
//  Copyright © 2020 MW. All rights reserved.
//

import UIKit
import Firebase

class AnalyticViewController: UIViewController {

    let days = ["Yesterday", "Today", "Prediction"]
    let charts = ["Yesterday's Chart", "Today's Chart", "Prediction's Chart"]
    let reuseIdentifier = "reuseCell"
    let initObjects = AnalyticView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 41/255, green: 40/255, blue: 102/255, alpha: 1)
        selectedItem()
        displayUserName()
        initObjectsActions()
    }
    
    override func loadView() {
        super.loadView()
        
        view = initObjects
    }
    
    func initObjectsActions() {
        
        initObjects.userNameButton.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        initObjects.userButton.addTarget(self, action: #selector(userAccountButtonPressed), for: .touchUpInside)
        initObjects.daysCollectionView.delegate = self
        initObjects.daysCollectionView.dataSource = self
        initObjects.daysCollectionView.register(AnalyticsCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        initObjects.chartCollectionView.delegate = self
        initObjects.chartCollectionView.dataSource = self
        initObjects.chartCollectionView.register(ChartCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func selectedItem() {
        
        let selectedItem = NSIndexPath(item: 1, section: 0)
        initObjects.daysCollectionView.selectItem(at: selectedItem as IndexPath, animated: true, scrollPosition: .centeredHorizontally)
        initObjects.daysCollectionView.scrollToItem(at: selectedItem as IndexPath, at: .centeredVertically, animated: true)
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        initObjects.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 3
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / initObjects.daysCollectionView.frame.width
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        initObjects.daysCollectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: .centeredHorizontally)
        
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        initObjects.chartCollectionView.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc func userAccountButtonPressed() {
        
         print(1)
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

extension AnalyticViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == initObjects.daysCollectionView {
            
            guard let cell = initObjects.daysCollectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? AnalyticsCell else { return UICollectionViewCell() }
            
            cell.dayLabel.text = days[indexPath.row]
            return cell
            
        } else {
            
            guard let cell = initObjects.chartCollectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ChartCell else { return UICollectionViewCell() }
            
            cell.chartLabel.text = charts[indexPath.row]
            return cell
            
        }
    }
    
}

extension AnalyticViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        scrollToMenuIndex(menuIndex: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == initObjects.daysCollectionView {
            return CGSize(width: initObjects.daysCollectionView.frame.width / 3, height: 50)
        } else {
            return CGSize(width: initObjects.chartCollectionView.frame.width, height: initObjects.chartCollectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
}
