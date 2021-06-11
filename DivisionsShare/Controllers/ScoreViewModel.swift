//
//  TestResultController.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 06/06/2021.
//

import Foundation
import FirebaseFirestore

// to do scores

class ScoreViewModel: ObservableObject {

    private let db = Firestore.firestore()

    var studentID: String = ""
    var testID: String = ""
    var divisionID: String = ""
    
    @Published var fullName = "" // if no score yet, but still need name
    @Published var hasScore: Bool = false
    @Published var score: Score = Score.blank
    @Published var test: Test = Test.blank

    func fetchFullName() {
        db.collection("users").document(self.studentID).getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                self.fullName = data?["fullName"] as? String ?? ""
            } else {
                print("Cannot get user fullName does not exist")
            }
        }
    }
    
    func fetchScore(){
        db.collection("scores").whereField("studentID", isEqualTo: studentID).whereField("testID", isEqualTo: testID).addSnapshotListener({(snapshot, error) in
            guard let documents = snapshot?.documents else {
                self.hasScore = false
                return
            }

            let scores = documents.map {docSnapshot -> Score in
                let data = docSnapshot.data()
                let id = docSnapshot.documentID
                let divisionID = data["divisionID"] as? String ?? ""
                let testID = data["testID"] as? String ?? ""
                let studentID = data["studentID"] as? String ?? ""
                let studentName = data["studentName"] as? String ?? ""
                let resultN = data["resultN"] as? Int ?? -1
                return Score(id: id, divisionID: divisionID, testID: testID, studentID: studentID, studentName: studentName, resultN: resultN)
            }
            
            if !scores.isEmpty {
                self.hasScore = true
                self.score = scores[0]
            } else {
                self.hasScore = false
            }
            
        })
    }
    
    func addScore(testID: String, resultNString: String){
        let resultN = Int(resultNString) ?? 0 // if have entered non-ints into decimal pad, make result 0
        if !self.hasScore {
            db.collection("scores").addDocument(data: ["divisionID": self.divisionID, "testID": testID, "studentID": self.studentID, "studentName": self.fullName, "resultN": resultN]) { err in
                if let err = err {
                    print("Error adding score: \(err)")
                } else {
                    print("Student score added")
                }
            }
        } else {
            // already has score -> edit score
            db.collection("scores").document(score.id).updateData(["resultN": resultN]) { err in
                if let err = err {
                    print("Error updating score: \(err)")
                } else {
                    print("Score successfully updated")
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
