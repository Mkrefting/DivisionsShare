//
//  DivisionsController.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class DivisionsController: ObservableObject {
    
    @Published var divisions: [Division] = []
    private let db = Firestore.firestore()
    let user = Auth.auth().currentUser
    
    func fetchData(){
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
                    return Division(id: id, name: name, joinCode: joinCode, teacherID: teacherID)
                })
            })
        }
    }
    
    func addDivision(name: String) {
        if (user != nil) {
            db.collection("divisions").addDocument(data: [
                                                    "name": name,
                                                    "joinCode": String(Int.random(in: 10000..<99999)),
                                                    "teacherID": user!.uid]) { err in
                if let err = err {
                    print("error adding document! \(err)")
                } else {
                    print("division added")
                }
            }
        }
    }
    
}
