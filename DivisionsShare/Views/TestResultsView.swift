//
//  TestResultsView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import SwiftUI

struct TestResultsView: View {
    
    @EnvironmentObject var authController: AuthController
    @EnvironmentObject var studentController: StudentController
    
    @State private var joinDivision: Bool = false
        
    var body: some View {
        NavigationView{
            List{
                ForEach(studentController.divisions){ division in
                    Text(division.name)
                }
            }
            .navigationBarTitle("Divisions")
            .onAppear{
                self.studentController.fetchData()
            }
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarLeading){
                    Text(authController.getUser().fullName)
                    Button(action: {
                        authController.signOut()
                    }, label: {
                        Text("Sign Out")
                    })
                    Spacer()
                    
                    // problems with this button after it gets clicked
                    Button(action: {
                        self.joinDivision = true
                    }, label: {
                        Text("Join Division")
                    })
                }
            }
            .sheet(isPresented: $joinDivision, content: {
                JoinDivisionView(isOpen: $joinDivision)
            })
        }
    }
}

struct TestResultsView_Previews: PreviewProvider {
    static var previews: some View {
        TestResultsView()
    }
}
