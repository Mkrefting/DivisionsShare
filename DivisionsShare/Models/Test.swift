//
//  Test.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import Foundation
import FirebaseFirestore

class Test: Identifiable {
    var id: String
    var divisionID: String
    var name: String
    var date: Date
    
    var dateString: String {
        let formatter = DateFormatter()
        //formatter.dateFormat = "EEEE, dd 'of' MMMM"
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
    
    init(id: String, divisionID: String, name: String, date: Date){
        self.id = id
        self.divisionID = divisionID
        self.name = name
        self.date = date
    }
    
}
