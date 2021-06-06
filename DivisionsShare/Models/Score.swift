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
    var resultN: Int
    
    init(id: String, testID: String, studentID: String, resultN: Int){
        self.id = id
        self.testID = testID
        self.studentID = studentID
        self.resultN = resultN
    }
    
    static let blank = Score(id: "", testID: "", studentID: "", resultN: -1)
    
}
