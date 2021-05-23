//
//  Division.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import Foundation
import FirebaseFirestore

class Division: Identifiable {
    var id: String
    var name: String
    var joinCode: String
    var teacherID: String
    var studentsID: [String]
    
    init(id: String, name: String, joinCode: String, teacherID: String, studentsID: [String]){
        self.id = id
        self.name = name
        self.joinCode = joinCode
        self.teacherID = teacherID
        self.studentsID = studentsID
    }
    
    #if DEBUG
    static let example = Division(id: "fa3k9rfu12", name: "vCZ-1", joinCode: "12345678", teacherID: "12345", studentsID: ["132"])
    #endif
}
