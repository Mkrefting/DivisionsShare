//
//  SignInView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import SwiftUI

struct SignInView: View {
    
    @EnvironmentObject var authState: AuthState
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationView{
            
            VStack{
                
                Image("homeImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding()
                
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
                    authState.signIn(email: email, password: password)
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
                
                
                /*Button(action: {
                    authState.signIn(email: "teacher@gmail.com", password: "password")
                }, label: {
                    Text("Teacher Auto Sign In")
                })
                
                Button(action: {
                    authState.signIn(email: "krefting@gmail.com", password: "password")
                }, label: {
                    Text("Student Auto Sign In")
                })*/
                
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

