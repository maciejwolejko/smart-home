//
//  FIRDatabaseService.swift
//  SmartHome
//
//  Created by MW on 4/16/20.
//  Copyright © 2020 MW. All rights reserved.
//

import Foundation
import Firebase

class FirebaseService {
    
    static let shared = FirebaseService()
    
    func reference(to databaseReference: FirebaseReference) -> DatabaseReference {
        return Database.database().reference().child(databaseReference.rawValue)
    }
    
    func configure() {
        FirebaseApp.configure()
    }
    
    //CRUD functions not finished yet.
    //Not enough experienced in Swift to complete this task using Firebase RealTime Database
    func create() {
    
    }
   
    func read() {
        
    }
    
    func update() {
        
    }
    
    func delete() {
        
    }
}
