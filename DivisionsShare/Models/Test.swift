//
//  Test.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import Foundation

class Test: Identifiable {
    var id: String
    var divisionID: String
    var name: String
    var date: Date
    var outOf: Int
    
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d.M.yy"
        //formatter.dateStyle = .short
        return formatter.string(from: date)
    }
    
    init(id: String, divisionID: String, name: String, date: Date, outOf: Int){
        self.id = id
        self.divisionID = divisionID
        self.name = name
        self.date = date
        self.outOf = outOf
    }
    
    static let blank = Test(id: "", divisionID: "", name: "", date: Date(), outOf: -1)
    
    #if DEBUG
    static let example = Test(id: "fa3k9rfu12", divisionID: "12345", name: "Algebra 101", date: Date(), outOf: 100)
    #endif
    
}
