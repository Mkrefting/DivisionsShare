//
//  StudentController.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class _StudentState: ObservableObject {
    
    private let db = Firestore.firestore()
    let user = Auth.auth().currentUser
    
    @Published var divisions: [Division] = []

    @Published var divisionChosen: Bool = false
    @Published var currentDivision: Division = Division.blank
    
    @Published var tests = [Test]()
    
    var id: String = "" // id of user collection, not authentication id (i.e. studentID)
    
    
    func setID(handler: @escaping () -> Void){
        if (user != nil) {
            print("Setting student id")
             db.collection("users").whereField("userID", isEqualTo: user!.uid).getDocuments() { (querySnapshot, err) in
                 if let err = err {
                     print("Error getting documents: \(err)")
                 } else {
                     for document in querySnapshot!.documents {
                        self.id = document.documentID
                     }
                 }
                print("Student id found: \(self.id)")
                handler()

             }
        } else {
            print("Cannot set user id")
        }
 }
    
    func fetchData(){
        
        // can only get tests data once division has been found
        print("INFO: Initial opening of tab view -> Fetching divisions, setting current division, fetch tests")
        self.setID(handler : {
            self._fetchDivisions(handler: {
                self._setCurrentDivision()
                self._fetchTests()
            })
        })
    }
    

    
    func _fetchDivisions(handler: @escaping () -> Void){
        if (user != nil) {
            print("Getting data for user with student ID \(self.id)")
            db.collection("divisions").whereField("studentIDs", arrayContains: self.id).addSnapshotListener({(snapshot, error) in
                guard let documents = snapshot?.documents else {
                    print ("no docs returned!")
                    return
                }
                
                print("Found divisions for student")

                self.divisions = documents.map({docSnapshot -> Division in
                    let data = docSnapshot.data()
                    let divId = docSnapshot.documentID
                    let name = data["name"] as? String ?? ""
                    let joinCode = data["joinCode"] as? String ?? ""
                    let teacherID = data["teacherID"] as? String ?? ""
                    let studentIDs = data["studentIDs"] as? [String] ?? []
                    //let studentNames = data["studentNames"] as? [String] ?? []
                    return Division(id: divId, name: name, joinCode: joinCode, teacherID: teacherID, studentIDs: studentIDs)
                })
                
                print(self.divisions)
        
                handler()
            })
        } else {
            print("Error getting student divs, no user found")
        }
    }
    
    
    func _setCurrentDivision(){
        // initial set currentDivision
        print("Setting Current Division")
        print("initial update of currentDivision, divisions is empty? \(self.divisions.isEmpty), divisionChosen? \(self.divisionChosen)")
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
    
    func updateCurrentDivision(division: Division){
        self.currentDivision = division
        self.divisionChosen = true
    }
    
    
    func fetchCurrentDivisionTests(){
        self._fetchTests()
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
    
    func joinDivision(joinCode: String, handler: @escaping () -> Void) {
        // check if such joinCode exists + add user to it
        if (user != nil) {
            db.collection("divisions").whereField("joinCode", isEqualTo: joinCode).getDocuments() { [self] (querySnapshot, err) in
                if let err = err {
                    print("Error checking joinCode: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.db.collection("divisions").document(document.documentID).updateData(["studentIDs": FieldValue.arrayUnion([self.id])])
                        handler()
                    }
                }
            }
        }
    }
}
