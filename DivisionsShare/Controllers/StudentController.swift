//
//  StudentController.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class StudentController: ObservableObject {
    
    @Published var divisions: [Division] = []
    private let db = Firestore.firestore()
    let user = Auth.auth().currentUser
    
    func fetchData(){
        if (user != nil) {
            db.collection("divisions").whereField("studentsID", arrayContains: user!.uid).addSnapshotListener({(snapshot, error) in
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
            })
        } else {
            print("Error getting student divs, no user found")
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
                        self.db.collection("divisions").document(document.documentID).updateData(["studentIDs": FieldValue.arrayUnion([user!.uid]), "studentNames": FieldValue.arrayUnion(["name"])])
                        handler()
                    }
                }
            }
        }
    }
}
