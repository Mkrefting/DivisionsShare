//
//  User.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 29/05/2021.
//

import Foundation
import FirebaseFirestore

class User: Identifiable {
    
    var id: String
    var fullName: String
    var userID: String
    var userType: String

    
    init(id: String, fullName: String, userID:String, userType: String){
        self.id = id
        self.fullName = fullName
        self.userID = userID
        self.userType = userType
    }
    
    static let blank = User(id: "", fullName: "", userID: "", userType: "")

}
