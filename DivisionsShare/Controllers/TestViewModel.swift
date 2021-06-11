//
//  TestViewModel.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 06/06/2021.
//

import Foundation
import FirebaseFirestore

class TestViewModel: ObservableObject {

    private let db = Firestore.firestore()

    var test: Test = Test.blank
    
    var closeDueToDelete: Bool = true // turn to false when a test is deleted and the testView page needs to close
    
    @Published var divisionName: String = ""
    @Published var studentIDs: [String] = []
    @Published var scores: [Score] = []
    
    func updateTest(name: String, date: Date, outOf: Int){
        db.collection("tests").document(self.test.id).updateData(["name": name, "date": date, "outOf": outOf]) { err in
            if let err = err {
                print("Error updating score: \(err)")
            } else {
                print("Score successfully updated")
            }
        }
    }
    
    func deleteTest(){
        db.collection("tests").document(self.test.id).delete() { err in
            if let err = err {
                print("Error deleting test with name \(self.test.name): \(err)")
            } else {
                print("Test with id \(self.test.id) successfully removed!")
            }
            self.test = Test.blank
        }
    }
    
    func setDivisionName(){
        let divisionID = test.divisionID
        db.collection("divisions").document(divisionID).getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                self.divisionName = data?["name"] as? String ?? ""
            } else {
                print("Division does not exist")
            }
        }
    }
    
    func fetchStudentIDs(){
        db.collection("divisions").document(test.divisionID).addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
              print("Error fetching division: \(error!)")
              return
            }
            guard let data = document.data() else {
              print("Document data was empty.")
              return
            }
            self.studentIDs = data["studentIDs"] as? [String] ?? []
        }
    }
    
    func fetchScores(){
        db.collection("scores").whereField("testID", isEqualTo: test.id).addSnapshotListener({(snapshot, error) in
            guard let documents = snapshot?.documents else {
                print("No scores to fetch")
                return
            }
            self.scores = documents.map {docSnapshot -> Score in
                let data = docSnapshot.data()
                let id = docSnapshot.documentID
                let divisionID = data["divisionID"] as? String ?? ""
                let testID = data["testID"] as? String ?? ""
                let studentID = data["studentID"] as? String ?? ""
                let studentName = data["studentName"] as? String ?? ""
                let resultN = data["resultN"] as? Int ?? -1
                return Score(id: id, divisionID: divisionID, testID: testID, studentID: studentID, studentName: studentName, resultN: resultN)
            }
        })
    }
    
    
    
    
    
}
