//
//  MainView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var authController: AuthController
    
    @State private var userType: String = ""
    
    var body: some View {
        VStack{
            if authController.userType
                == "Teacher"{
                DivisionsView()
            } else if authController.userType == "Student" {
                StudentTabView()
            } else {
                Text("") // loading (maybe put spinning wheel?
            }
        }.onAppear{
            self.authController.setUserType()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
