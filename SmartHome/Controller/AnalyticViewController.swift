//
//  AnalyticViewController.swift
//  SmartHome
//
//  Created by MW on 3/26/20.
//  Copyright © 2020 MW. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "reuseCell"

class AnalyticViewController: UIViewController {

    let days = ["Yesterday", "Today", "Prediction"]
    let screen = UIScreen.main.bounds
    let charts = ["Yesterday's Chart", "Today's Chart", "Prediction's Chart"]
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    
    private lazy var userNameButton: UIButton = {
        let bt = UIButton()
        bt.setTitleColor(.white, for: .normal)
        bt.titleLabel?.font = .systemFont(ofSize: 25)
        bt.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    private lazy var userButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "user")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(userAccountButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var daysCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AnalyticsCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var chartCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ChartCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var line: UIView = {
        let line = UIView(frame: .zero)
        line.backgroundColor = .gray
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    private lazy var horizontalBar: UIView = {
        let line = UIView(frame: .zero)
        line.backgroundColor = UIColor(red: 27/255, green: 183/255, blue: 233/255, alpha: 1)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 41/255, green: 40/255, blue: 102/255, alpha: 1)
        setupObjects()
        selectedItem()
        horizontalBarLeftAnchorConstraint?.constant = 111.33
        displayUserName()
        
    }
    
    func selectedItem() {
        let selectedItem = NSIndexPath(item: 1, section: 0)
        daysCollectionView.selectItem(at: selectedItem as IndexPath, animated: true, scrollPosition: .centeredHorizontally)
        daysCollectionView.scrollToItem(at: selectedItem as IndexPath, at: .centeredVertically, animated: true)
        
    }

    func setupObjects() {
        [userNameButton, userButton, daysCollectionView, line, horizontalBar, chartCollectionView].forEach{view.addSubview($0)}
        
        userNameButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 20, bottom: 0, right: 0))
        
        userButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 20), size: .init(width: 45, height: 45))
        
        daysCollectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 100, left: 40, bottom: 0, right: 40), size: .init(width: 0, height: 50))
        
        line.anchor(top: daysCollectionView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 2.5, left: 10, bottom: 0, right: 10), size: .init(width: 0, height: 1))
        
        horizontalBarLeftAnchorConstraint = horizontalBar.leftAnchor.constraint(equalTo: daysCollectionView.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            horizontalBar.bottomAnchor.constraint(equalTo: daysCollectionView.bottomAnchor, constant: 2.5),
            horizontalBar.widthAnchor.constraint(equalTo: daysCollectionView.widthAnchor, multiplier: 1/3),
            horizontalBar.heightAnchor.constraint(equalToConstant: 1),
        ])
        
        chartCollectionView.anchor(top: line.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 40, bottom: 0, right: 40))
    }
    
    func displayUserName() {
        Database.database().reference().child("registeredUsers")
            .queryOrdered(byChild: "uid")
            .queryEqual(toValue: Auth.auth().currentUser?.uid)
            .observe(.childAdded) { (snapshot) in
                if let dictionary = snapshot.value as? [String: Any] {
                    let name = dictionary["name"] as? String
                    self.userNameButton.setTitle("Hi, \(name!)", for: .normal)
                }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 3
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / daysCollectionView.frame.width
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        daysCollectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: .centeredHorizontally)
        
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        chartCollectionView.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: true)
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

extension AnalyticViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == daysCollectionView {
            let cell = daysCollectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AnalyticsCell
            
            cell.dayLabel.text = days[indexPath.row]
            
            return cell
        } else {
            let cell = chartCollectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChartCell
            
            cell.chartLabel.text = charts[indexPath.row]
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        scrollToMenuIndex(menuIndex: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == daysCollectionView {
            return CGSize(width: daysCollectionView.frame.width / 3, height: 50)
        } else {
            return CGSize(width: chartCollectionView.frame.width, height: chartCollectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
