//
//  StudentViewModel.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 06/06/2021.
//

import Foundation
import FirebaseFirestore

class StudentViewModel: ObservableObject {

    private let db = Firestore.firestore()

    var ID: String = ""
    var divisionID: String = ""
    
    @Published var fullName = "" // if no score yet, but still need name
    
    @Published var scores: [Score] = [] // of this student
    
    // stats
    @Published var totalPercentage: Double = 0
    @Published var nPercentages: Int = 0 // equal to scores.length
    

    func fetchFullName() {
        db.collection("users").document(self.ID).getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                self.fullName = data?["fullName"] as? String ?? ""
            } else {
                print("Cannot get user fullName does not exist")
            }
        }
    }
    
    func fetchScores(){
        db.collection("scores").whereField("studentID", isEqualTo: ID).whereField("divisionID", isEqualTo: divisionID).addSnapshotListener({(snapshot, error) in
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
            
            self.scores.forEach { score in
                self.updateAveragePercentage(score: score)
            }
            
        })
    }
    
    /*func fetchStats(){
        scores.forEach { score in
            self.updateAveragePercentage(score: score)
        }
    }*/
    
    func updateAveragePercentage(score: Score) {
        db.collection("tests").document(score.testID).getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                let outOf = data?["outOf"] as? Int ?? 0
                self.totalPercentage += Double(score.resultN) / Double(outOf) * 100
                self.nPercentages += 1
            } else {
                print("Cannot get percentage")
            }
        }
    }
        
    
}
