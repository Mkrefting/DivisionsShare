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
    
    @Published var userType = ""

    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Signed In")
            }
            
            DispatchQueue.main.async {
                self?.setUserType()
                self?.signedIn = true
            }
        }
    }
    
    func signUp(email: String, password: String, userType: String, fullName: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Signed Up")
                self?.addUser(userType: userType, fullName: fullName)
            }
            DispatchQueue.main.async {
                self?.setUserType()
                self?.signedIn = true
            }
        }
        
    }
    
    func addUser(userType: String, fullName: String){
        let user = Auth.auth().currentUser
        if (user != nil) {
            db.collection("users").addDocument(data: ["userID": user!.uid, "fullName": fullName, "userType": userType]) { err in
                if let err = err {
                    print("error adding document! \(err)")
                } else {
                    print("user type added")
                }
            }
        } else {
            print("cannot add user to users documentation")
        }
    }
    
    func setUserType() {
        var val = "no userType found"
        if (auth.currentUser != nil) {
            db.collection("users").whereField("userID", isEqualTo: auth.currentUser!.uid)
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting user type: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            let data = document.data()
                            val = data["userType"] as? String ?? ""
                        }
                        
                        DispatchQueue.main.async {
                            self.userType = val
                        }
                        
                    }
            }
        } else {
            print("Failed to set userType, no user logged in found")
        }
    }
    
    func getUser() -> User {
        var user = User.example
        let authUser = Auth.auth().currentUser
        if (authUser != nil) {
            db.collection("users").whereField("userID", isEqualTo: authUser!.uid).addSnapshotListener({(snapshot, error) in
                guard (snapshot?.documents) != nil else {
                    print ("no docs returned!")
                    return
                }
                
                for document in snapshot!.documents {
                    let data = document.data()
                    let userID = data["userID"] as? String ?? ""
                    let fullName = data["fullName"] as? String ?? ""
                    let userType = data["userType"] as? String ?? ""
                    //let divisionIDs = data["divisionIDs"] as? [String] ?? []
                    user = User(id: userID, fullName: fullName, userType: userType)
                }
            })
        } else {
            print("no user found - cannot fetch data")
        }
        return user
    }
    
    func signOut() {
        try? auth.signOut()
        self.signedIn = false
    }

}
