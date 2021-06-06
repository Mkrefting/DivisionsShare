//
//  ContentView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authController: AuthState
    
    var body: some View {
        VStack{
            if authController.isSignedIn {
                InterfaceChoiceView()
            }
            else {
                SignInView()
            }
        }.onAppear {
            authController.signedIn = authController.isSignedIn
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
