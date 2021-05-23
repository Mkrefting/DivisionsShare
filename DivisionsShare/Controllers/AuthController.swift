//
//  AuthController.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import Firebase
import FirebaseFirestore
import FirebaseAuth

class AuthController: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    let db = Firestore.firestore()
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Signed In")
            }
            
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
        
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Signed Up")
            }
            
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
        
    }
    
    func signOut() {
        try? auth.signOut()
        self.signedIn = false
    }

}
