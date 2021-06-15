//
//  MainView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import SwiftUI

struct InterfaceChoiceView: View {
    
    @EnvironmentObject var authState: AuthState
    
    @State private var userType: String = ""
    
    var body: some View {
        VStack{
            if authState.userType == "Teacher"{
                TeacherTabView()
                    .environmentObject(TeacherState())
            } else if authState.userType == "Student" {
                _StudentTabView()
                    .environmentObject(_StudentState())
            } else {
                SignInView()
            }
        }
    }
}
