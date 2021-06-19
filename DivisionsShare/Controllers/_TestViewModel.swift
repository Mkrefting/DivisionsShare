//
//  _TestViewModel.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 16/06/2021.
//

import Foundation
import FirebaseFirestore

class _TestViewModel: ObservableObject {

    private let db = Firestore.firestore()

    var studentID: String = ""
    var testID: String = ""
    
    @Published var hasScore: Bool = false
    @Published var score: Score = Score.blank
    @Published var test: Test = Test.blank

    func fetchData(){
        self.getScore()
        self.getTest()
    }
    
    func getScore(){
        db.collection("scores").whereField("studentID", isEqualTo: studentID).whereField("testID", isEqualTo: testID) .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting user type: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let id = document.documentID
                    let divisionID = data["divisionID"] as? String ?? ""
                    let testID = data["testID"] as? String ?? ""
                    let studentID = data["studentID"] as? String ?? ""
                    let studentName = data["studentName"] as? String ?? ""
                    let resultN = data["resultN"] as? Int ?? -1
                    self.score = Score(id: id, divisionID: divisionID, testID: testID, studentID: studentID, studentName: studentName, resultN: resultN)
                }
            }
        }
    }
    
    func getTest() {
        db.collection("tests").document(testID).getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                let docId = document.documentID
                let divisionID = data?["divisionID"] as? String ?? ""
                let name = data?["name"] as? String ?? ""
                let date = (data?["date"] as? Timestamp)?.dateValue() ?? Date()
                let outOf = data?["outOf"] as? Int ?? -1
                let allScoresEntered = data?["allScoresEntered"] as? Bool ?? false
                self.test = Test(id: docId, divisionID: divisionID, name: name, date: date, outOf: outOf, allScoresEntered: allScoresEntered)
            } else {
                print("Test does not exist")
            }
        }
    }

}
