//
//  AuthController.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import Firebase
import FirebaseFirestore
import FirebaseAuth

class AuthState: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    let db = Firestore.firestore()
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    @Published var userType = ""
    
    //var user: User = User.blank

    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
            }
                    
            DispatchQueue.main.async {
                if result != nil {
                    print("User signed in, with result \(String(describing: result))")
                    self?.setUserType()
                    self?.signedIn = true
                    //self?.getUserDetails()
                } else {
                    print("Cannot sign user in")
                }
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
                //self?.getUserDetails()
            }
        }
        
    }
    
    func addUser(userType: String, fullName: String){
        if (auth.currentUser != nil) {
            db.collection("users").addDocument(data: ["userID": auth.currentUser!.uid, "fullName": fullName, "userType": userType]) { err in
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
    
    /*func getUserDetails() {
        if (auth.currentUser != nil) {
            db.collection("users").whereField("userID", isEqualTo: auth.currentUser!.uid).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        let id = document.documentID // as in the collection document id
                        let userID = data["userID"] as? String ?? "" // the id referencing authenticated user
                        let fullName = data["fullName"] as? String ?? ""
                        let userType = data["userType"] as? String ?? ""
                        //let divisionIDs = data["divisionIDs"] as? [String] ?? []
                        self.user = User(id: id, fullName: fullName, userID: userID, userType: userType)
                    }
                }
    
            }
        }
    }*/
    
    func signOut() {
        do {
          try auth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        self.signedIn = false
    }


}
