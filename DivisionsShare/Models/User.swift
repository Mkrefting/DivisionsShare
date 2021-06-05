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
    var userType: String
    var divisionIDs: [String]

    
    init(id: String, fullName: String, userType: String, divisionIDs: [String]){
        self.id = id
        self.fullName = fullName
        self.userType = userType
        self.divisionIDs = divisionIDs
    }
    
    #if DEBUG
    static let example = User(id: "fa3k9rfu12", fullName: "Example Student", userType: "Student", divisionIDs: ["123"])
    #endif
}
