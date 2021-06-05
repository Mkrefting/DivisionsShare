//
//  TestsController.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class TestsHandler: ObservableObject {
    
    @Published var tests = [Test]()
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser

    func fetchData(divisionID: String) {
        if (user != nil) {
            db.collection("tests").whereField("divisionID", isEqualTo: divisionID).order(by: "date", descending: true).addSnapshotListener({(snapshot, error) in
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
    
    func addTest(name: String, divisionID: String, date: Date) {
        if (user != nil) {
            db.collection("tests").addDocument(data: ["divisionID": divisionID, "date": date, "name": name]) { err in
                if let err = err {
                    print("error adding document! \(err)")
                } else {
                    print("test added")
                }
            }
        }
    }
}
