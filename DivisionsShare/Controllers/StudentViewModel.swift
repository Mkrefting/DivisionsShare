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
    
    @Published var fullName = "" // if no score yet, but still need name

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
    
}
