//
//  DivisionsController.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class DivisionsHandler: ObservableObject {
    
    @Published var divisions: [Division] = []
    private let db = Firestore.firestore()
    
    @Published var divisionChosen: Bool = false
    @Published var currentDivision: Division = Division.blank

    func fetchData(handler: @escaping () -> Void){
        let user = Auth.auth().currentUser
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
    
    func setCurrentDivision(){
        // initial set currentDivision
        print("Setting Current Division")
        if !self.divisionChosen && !self.divisions.isEmpty {
            print("initial update of currentDivision")
            self.updateCurrentDivision(divisionName: self.divisions[0].name)
        } else {
            print("NO initial update of current division")
        }
    }
    
    func updateCurrentDivision(divisionName: String) {
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
    
    func canAddDivision(name: String) -> Bool {
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
    
    func addDivision(name: String) {
        let user = Auth.auth().currentUser
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
                self.updateCurrentDivision(divisionName: name)
            }
        } else {
            print("no user - cannot add division")
        }
        
    }
    
}
