//
//  ContentView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authState: AuthState
    
    var body: some View {
        VStack{
            if authState.isSignedIn {
                InterfaceChoiceView()
            }
            else {
                SignInView()
            }
        }.onAppear {
            authState.signedIn = authState.isSignedIn
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
