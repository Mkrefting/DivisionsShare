//
//  Result.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 05/06/2021.
//

import Foundation

class Score: Identifiable {
    var id: String
    var testID: String
    var studentID: String
    var num: Int
    
    init(id: String, testID: String, studentID: String, num: Int){
        self.id = id
        self.testID = testID
        self.studentID = studentID
        self.num = num
    }
    
}
