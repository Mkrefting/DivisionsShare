//
//  SignInView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import SwiftUI

struct SignInView: View {
    
    @EnvironmentObject var authController: AuthController
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationView{
            
            VStack{
                
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
                    authController.signIn(email: email, password: password)
                }, label: {
                    Text("Sign In")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(15)

                })
                
                
                NavigationLink("Create Account", destination: SignUpView())
                    .padding()
                
                Spacer()
                
                
                Button(action: {
                    authController.signIn(email: "teacher@gmail.com", password: "password")
                }, label: {
                    Text("Debug Auto Sign In")
                })
                
            }.navigationBarTitle("Sign In")
            .padding()
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

