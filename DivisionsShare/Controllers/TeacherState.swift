//
//  StateController.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 05/06/2021.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class TeacherState: ObservableObject {

    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser

    @Published var divisions: [Division] = []
    @Published var tests = [Test]()

    @Published var divisionChosen: Bool = false
    @Published var currentDivision: Division = Division.blank

    @Published var currentTest: Test = Test.blank
    
    @Published var currentTestScores: [Score] = []
    
    /// EXTERNAL FUNCTIONS
    
    func fetchData(){
        // can only get tests data once division has been found
        print("INFO: Initial opening of tab view -> Fetching divisions, setting current division, fetch tests")
        self._fetchDivisions(handler: {
            self._setCurrentDivision()
            self._fetchTests()
        })
    }
    
    func updateCurrentDivision(division: Division){
        self.currentDivision = division
        self.divisionChosen = true
    }
    
    func fetchCurrentDivisionTests(){
        self._fetchTests()
    }
    
    func addDivision(name: String) -> Bool {
        if self._canAddDivision(name: name){
            self._addDivision(name: name)
            return true
        } else {
            return false
        }
    }
    
    func addTest(name: String, date: Date, outOf: Int){
        self._addTest(name: name, date: date, outOf: outOf)
    }
    
    func evaluateCurrentTestStatus(){
        self._calculateTestStatus(testID: self.currentTest.id)
    }
    
    /// INTERNAL FUNCTIONS

    func _fetchDivisions(handler: @escaping () -> Void){
        if (user != nil) {
            db.collection("divisions").whereField("teacherID", isEqualTo: user!.uid).addSnapshotListener({(snapshot, error) in
                guard let documents = snapshot?.documents else {
                    print ("no docs returned!")
                    return
                }
                
                self.divisions = documents.map({docSnapshot -> Division in
                    let data = docSnapshot.data()
                    let id = docSnapshot.documentID
                    let name = data["name"] as? String ?? ""
                    let joinCode = data["joinCode"] as? String ?? ""
                    let teacherID = data["teacherID"] as? String ?? ""
                    let studentIDs = data["studentIDs"] as? [String] ?? []
                    //let studentNames = data["studentNames"] as? [String] ?? []
                    return Division(id: id, name: name, joinCode: joinCode, teacherID: teacherID, studentIDs: studentIDs)
                })
                
                handler()
            })
        } else {
            print("no user found - cannot fetch data")
        }
    }
    
    func _setCurrentDivision(){
        // initial set currentDivision
        print("Setting Current Division")
        if !self.divisionChosen && !self.divisions.isEmpty {
            print("initial update of currentDivision, divisions is empty? \(self.divisions.isEmpty), divisionChosen? \(self.divisionChosen)")
            self._updateCurrentDivision(divisionName: self.divisions[0].name)
        } else {
            print("NO initial update of current division")
        }
    }
    
    func _updateCurrentDivision(divisionName: String) {
        var hasChangedDivision = false
        self.divisions.forEach { division in
            if division.name == divisionName {
                self.currentDivision = division
                hasChangedDivision = true
                self.divisionChosen = true
            }
        }
        print(hasChangedDivision ? "currentDivision updated" : "new division not found, currentDivision NOT updated")
    }
    
    func _canAddDivision(name: String) -> Bool {
        // check if division name already used by that teacher
        var nameTaken = false
        divisions.forEach { division in
            if division.name == name {
                nameTaken = true
                print("Cannot add division - name already taken")
            }
        }
        return !nameTaken
    }
    
    func _addDivision(name: String) {
        if (user != nil) {
            db.collection("divisions").addDocument(data: [
                                                    "name": name,
                                                    "joinCode": String(Int.random(in: 10000..<99999)),
                                                    "teacherID": user!.uid,
                                                    "studentIDs":[]]) { err in
                if let err = err {
                    print("error adding document! \(err)")
                } else {
                    print("division added")
                }
                self._updateCurrentDivision(divisionName: name)
                self._fetchTests()
            }
        } else {
            print("no user - cannot add division")
        }
    }
    
    func _fetchTests() {
        if (user != nil) {
            db.collection("tests").whereField("divisionID", isEqualTo: self.currentDivision.id).order(by: "date", descending: true).addSnapshotListener({(snapshot, error) in
                guard let documents = snapshot?.documents else {
                    print("no documents")
                    return
                }
                
                self.tests = documents.map { docSnapshot -> Test in
                    let data = docSnapshot.data()
                    let docId = docSnapshot.documentID
                    let divisionID = data["divisionID"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let date = (data["date"] as? Timestamp)?.dateValue() ?? Date()
                    let outOf = data["outOf"] as? Int ?? -1
                    let allScoresEntered = data["allScoresEntered"] as? Bool ?? false
                    return Test(id: docId, divisionID: divisionID, name: name, date: date, outOf: outOf, allScoresEntered: allScoresEntered)
                }
            })
        }
    }
    
    func _addTest(name: String, date: Date, outOf: Int) {
        if (user != nil) {
            db.collection("tests").addDocument(data: ["divisionID": self.currentDivision.id, "date": date, "name": name, "outOf": outOf, "allScoresEntered": false]) { err in
                if let err = err {
                    print("error adding document! \(err)")
                } else {
                    print("test added")
                }
            }
        }
    }
    
    func _calculateTestStatus(testID: String) {
        // check if there exists a document for each student ID + testID combo
        var allScoresEntered = true
        self.currentDivision.studentIDs.forEach { studentID in
            db.collection("scores")
                .whereField("testID", isEqualTo: testID)
                .whereField("studentID", isEqualTo: studentID)
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        if querySnapshot!.documents.isEmpty {
                            allScoresEntered = false
                            self._updateTestStatus(testID: testID, allScoresEntered: false)
                        }
                    }
            }
        }
        self._updateTestStatus(testID: testID, allScoresEntered: allScoresEntered)
    }
    
    func _updateTestStatus(testID: String, allScoresEntered: Bool) {
        if allScoresEntered != self.tests.filter( { $0.id == testID}).first?.allScoresEntered {
            // only update if has changed!
            db.collection("tests").document(testID).updateData(["allScoresEntered": allScoresEntered]) { err in
                if let err = err {
                    print("Error updating test allScoresEntered: \(err)")
                } else {
                    print("Test allScoresEntered successfully updated")
                }
            }
        }
    }
}

// scores (including delete)
// filtering
