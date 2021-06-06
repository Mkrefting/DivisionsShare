//
//  MainView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import SwiftUI

struct InterfaceChoiceView: View {
    
    @EnvironmentObject var authController: AuthState
    
    @State private var userType: String = ""
    
    var body: some View {
        VStack{
            if authController.userType == "Teacher"{
                TeacherTabView()
            } else if authController.userType == "Student" {
                StudentTabView()
            } else {
                SignInView()
            }
        }
    }
}
