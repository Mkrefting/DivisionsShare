//
//  DivisionView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 04/06/2021.
//

import SwiftUI

struct TestsView: View {
    
    @EnvironmentObject var teacherController: TeacherState
    @State private var addDivision: Bool = false
    @State private var addTest: Bool = false
    let filters = ["All", "Pending"]
    @State private var filterIndex: Int = 0
        
    var body: some View {
        NavigationView {
            
            VStack {
                
                if teacherController.divisionChosen {
                    
                    // filter lists
                    Picker("", selection: $filterIndex) {
                        ForEach(0 ..< filters.count) {
                            Text(self.filters[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle()).padding()
                    
                    List {
                        ForEach(teacherController.tests){ test in
                            if !(filterIndex == 1 && test.allScoresEntered){
                                NavigationLink(destination: TestView(test: test)){
                                    TestRow(test: test)
                                }
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
