//
//  ScoreRow.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 06/06/2021.
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
                    self.teacherController.evaluateCurrentTestStatus()
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
