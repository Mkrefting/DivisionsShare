//
//  DivisionView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 04/06/2021.
//

import SwiftUI

struct TestsView: View {
    
    @EnvironmentObject var teacherController: TeacherController
    @State private var addDivision: Bool = false
    @State private var addTest: Bool = false
        
    var body: some View {
        NavigationView {
            
            VStack {
                
                if teacherController.divisionChosen {
                    List {
                        ForEach(teacherController.tests){ test in
                            NavigationLink(destination: TestView(test: test)){
                                TestRow(test: test)
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                } else {
                    Text("No Division Selected")
                }
                
            }
            .navigationBarTitle("Your Division", displayMode: .inline)
            .toolbar{
                
                ToolbarItem(placement: .navigationBarLeading) {
                    DivisionsMenuBarItem(addDivision: $addDivision)
                        .sheet(isPresented: $addDivision, content: {
                            AddDivisionView(isOpen: $addDivision)
                        })
                }
            
                ToolbarItem(placement: .navigationBarTrailing) {
                    if teacherController.divisionChosen { // only show "Add Test" if a division has been chosen
                        Button("Add Test"){
                            self.addTest = true
                            print("Adding Test")
                        }.sheet(isPresented: $addTest, content: {
                            AddTestView(isOpen: $addTest)
                        })
                    }
                }
            }
        }
    }
    
}
