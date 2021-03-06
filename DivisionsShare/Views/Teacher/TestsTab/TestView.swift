//
//  TestView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 04/06/2021.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var teacherState: TeacherState
    @StateObject var testVM = TestViewModel()
    @Environment(\.presentationMode) var presentationMode // used when test is deleted
    @State private var showEdit: Bool = false
    let test: Test
    
    var body: some View {
        
        VStack{
            
            HStack {
                VStack(alignment: .leading) {
                    Text("\(testVM.divisionName)").italic()
                    Text("\(test.dateString)").bold()
                }.padding(20)
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Out of")
                    Text("\(testVM.test.outOf)")
                }.padding(20)
            }
            
            // i need to be filter through the list of students: looking at their names or their score.resultN
            // i can find their names
            // but can't find their scoreN...
            // maybe create score before? - each score should have 'added?'
            
            /*List {
                ForEach(testVM.scores){ score in
                    ScoreRow(studentID: score.studentID)
                }
            }
            .listStyle(InsetGroupedListStyle())*/

            List {
                ForEach(testVM.studentIDs, id: \.self){ studentID in
                    ScoreRow(studentID: studentID)
                }
            }
            .listStyle(InsetGroupedListStyle())
            // show stats here
        }
        .onChange(of: testVM.closeDueToDelete) { _ in
            presentationMode.wrappedValue.dismiss()
            testVM.closeDueToDelete = false
        }
        //.navigationBarTitle(Text(test.name), displayMode: .inline)
        .navigationBarTitle(Text(test.name))

        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    self.showEdit = true
                    //testVM.deleteCurrentTest()
                    //presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .onAppear {
            teacherState.currentTest = test
            testVM.test = test
            testVM.setDivisionName()
            testVM.fetchStudentIDs()
            testVM.fetchScores()
        }
        .onDisappear {
            testVM.updatePositions()
        }
        .sheet(isPresented: $showEdit, content: {
            EditTestView(testVM: testVM, isOpen: $showEdit)
        })
        
    }
}



struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(test: Test.example)
    }
}
