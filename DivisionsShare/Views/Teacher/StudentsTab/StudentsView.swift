//
//  StudentsView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import SwiftUI

struct StudentsView: View {
    
    @EnvironmentObject var teacherState: TeacherState
    @EnvironmentObject var authState: AuthState

    @State private var addDivision: Bool = false
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                HStack(){
                    Spacer()
                    Text("Join PIN")
                    Spacer()
                    Text(teacherState.currentDivision.joinCode)
                    Spacer()
                }.padding()
                
                List {
                    //teacherState.divisions
                    ForEach(teacherState.currentDivision.studentIDs, id: \.self){ studentID in
                        NavigationLink(destination: StudentView(ID: studentID)){
                            StudentRow(ID: studentID)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())

            }
            .navigationBarTitle("Students")
            .toolbar{
                
                ToolbarItem(placement: .navigationBarLeading) {
                    DivisionsMenuBarItem(addDivision: $addDivision)
                        .sheet(isPresented: $addDivision, content: {
                            AddDivisionView(isOpen: $addDivision)
                        })
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        authState.signOut()
                    }) {
                        Text("Sign Out").font(.caption)
                    }
                }
            }
        }
    }
}
