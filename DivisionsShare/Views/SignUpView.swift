//
//  SignUpView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var authController: AuthState
    
    let userTypes = ["Student", "Teacher"]
    @State private var userSelection: Int = 0
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
            VStack{
                
                VStack{
                    Text("You are a \(self.userTypes[userSelection])").italic()
                    Picker(selection: $userSelection, label: Text("Select Movie Genere")) {
                        ForEach(0..<userTypes.count){
                            Text(self.userTypes[$0])
                        }
                    }
                }.pickerStyle(SegmentedPickerStyle())
                .padding()
                
                TextField("Full Name", text: $fullName)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color(.secondarySystemBackground))

                TextField("Email Address", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
    
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
            
                Button(action: {
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    authController.signUp(email: email, password: password, userType: self.userTypes[userSelection], fullName: fullName)
                }, label: {
                    Text("Create Account")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(15)

                })
                
                Spacer()
                
            }.navigationBarTitle("Sign Up")
            .padding()
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

