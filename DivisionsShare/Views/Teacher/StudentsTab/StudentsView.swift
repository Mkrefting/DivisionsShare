//
//  StudentsView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import SwiftUI

struct StudentsView: View {
    
    @EnvironmentObject var teacherState: TeacherState
    @State private var addDivision: Bool = false
    
    var body: some View {
        NavigationView {
            
            VStack {
                List {
                    ForEach(teacherState.currentDivision.studentIDs, id: \.self){ studentID in
                        NavigationLink(destination: StudentView(ID: studentID)){
                            StudentRow(ID: studentID)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                
            }
            .navigationBarTitle("Students", displayMode: .inline)
            .toolbar{
                
                ToolbarItem(placement: .navigationBarLeading) {
                    DivisionsMenuBarItem(addDivision: $addDivision)
                        .sheet(isPresented: $addDivision, content: {
                            AddDivisionView(isOpen: $addDivision)
                        })
                }
            }
        }
    }
}
