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
    let test: Test
    
    var body: some View {
        
        VStack{
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Division:")
                    Text("Date:")
                    Text("Out of:")
                }.padding()
                Spacer()
                VStack(alignment: .trailing) {
                    Text("\(testVM.divisionName)")
                    Text("\(test.dateString)")
                    Text("\(testVM.test.outOf)")
                }.padding()
            }
            
            // i need to be filter through the list of students: looking at their names or their score.resultN
            // i can find their names
            // but can't find their scoreN...
            // maybe create score before?
            
            List {
                ForEach(testVM.studentIDs, id: \.self){ studentID in
                    ScoreRow(studentID: studentID)
                }
            }
            .listStyle(InsetGroupedListStyle())
            // show stats here
        }
        .navigationBarTitle(Text(test.name), displayMode: .inline)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    testVM.deleteCurrentTest()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "trash")
                        .font(.largeTitle)
                }
            }
        }
        .onAppear {
            teacherState.currentTest = test
            testVM.test = test
            testVM.setDivisionName()
            testVM.fetchStudentIDs()
        }
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(test: Test.example)
    }
}
