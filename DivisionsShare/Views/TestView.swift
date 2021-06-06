//
//  TestView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 04/06/2021.
//

import SwiftUI

struct ScoreRow: View {
    
    @EnvironmentObject var teacherController: TeacherController
    @StateObject var state = TestScoreController()
    
    let ID: String
    
    @State private var addingScore: Bool = false
    @State private var resultN: String = ""
    
    var body: some View {
        HStack {
            Text(state.fullName)
            Spacer()
            if !addingScore {
                if state.hasScore {
                    Text(String(state.score.resultN))
                    Button(action: {
                        self.addingScore = true // technically this is editing a score - this difference is handled in the controller
                    }) {
                        Image(systemName: "pencil")
                    }
                } else {
                    Button(action: {
                        self.addingScore = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            } else {
                TextField(resultN, text: $resultN)
                    .keyboardType(.decimalPad)
                    .frame(width: 50, height: nil)
                    .padding(.all, 5)
                    .background(Color(.secondarySystemBackground))
                Button("Done"){
                    self.state.addScore(testID: teacherController.currentTest.id, resultNString: resultN)
                    self.addingScore = false
                }
            }
            
        }
        .onAppear {
            self.state.studentID = ID
            self.state.testID = teacherController.currentTest.id
            self.state.fetchFullName()
            self.state.fetchScoreStatus()
            resultN = String(Int(teacherController.currentTest.outOf / 2 ))
            if state.hasScore {
                resultN = String(state.score.resultN)
            }
        }
    }
}

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
        }
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(test: Test.example)
    }
}
