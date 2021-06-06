//
//  TestView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 04/06/2021.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var teacherController: TeacherController
    @Environment(\.presentationMode) var presentationMode // used when test is deleted
    //@State private var selectedStudentIndex: Int = 0

    let test: Test
    
    var body: some View {
        
        VStack{
            Text("Out of: \(teacherController.currentTest.outOf)")
            List {
                ForEach(teacherController.currentDivision.studentIDs, id: \.self){ studentID in
                    ScoreRow(ID: studentID)
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationBarTitle(Text(test.name), displayMode: .inline)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    teacherController.deleteCurrentTest()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "trash")
                        .font(.largeTitle)
                }
            }
        }
        .onAppear {
            self.teacherController.currentTest = test
            //self.teacherController.fetchCurrentTestScores()
            print(test.name)
            print(teacherController.currentTest.name)
        }
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(test: Test.example)
    }
}
