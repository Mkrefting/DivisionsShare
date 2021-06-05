//
//  TestView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 04/06/2021.
//

import SwiftUI

struct ScoreRow: View {
    let score: Score
    
    var body: some View {
        HStack {
            Text(score.studentID)
            Spacer()
            Text(score.num)
        }
    }
}

struct TestView: View {
    
    @EnvironmentObject var teacherController: TeacherController
    @Environment(\.presentationMode) var presentationMode // used when test is deleted

    let test: Test
    
    var body: some View {
        
        VStack{
            
            HStack{
                // picker showing all students without a score
                // text field to enter integer score
            }
            // button to submit above, should clear above too
            
            // list showing all scores so far
            List {
                ForEach(teacherController.currentTestScores){ score in
                    ScoreRow(score: score)
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
            self.teacherController.fetchCurrentTestScores()
        }
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(test: Test.example)
    }
}
