//
//  StateController.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 05/06/2021.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class TeacherController: ObservableObject {

    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser

    @Published var divisions: [Division] = []
    @Published var tests = [Test]()

    @Published var divisionChosen: Bool = false
    @Published var currentDivision: Division = Division.blank

    //let divisionsHandler: DivisionsHandler = DivisionsHandler()
    //let testsHandler: TestsHandler = TestsHandler()
    
    /// EXTERNAL FUNCTIONS
    
    func fetchData(){
        // can only get tests data once division has been found
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
    
    func addTest(name: String, date: Date){
        self._addTest(name: name, date: date)
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
                    let studentNames = data["studentNames"] as? [String] ?? []
                    return Division(id: id, name: name, joinCode: joinCode, teacherID: teacherID, studentIDs: studentIDs, studentNames: studentNames)
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
            print("initial update of currentDivision")
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
                                                    "studentIDs":[],
                                                    "studentNames":[]]) { err in
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
                    return Test(id: docId, divisionID: divisionID, name: name, date: date)
                }
            })
        }
    }
    
    func _addTest(name: String, date: Date) {
        if (user != nil) {
            db.collection("tests").addDocument(data: ["divisionID": self.currentDivision.id, "date": date, "name": name]) { err in
                if let err = err {
                    print("error adding document! \(err)")
                } else {
                    print("test added")
                }
            }
        }
    }
    
}
