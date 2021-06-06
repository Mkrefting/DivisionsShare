//
//  ScoreRow.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 06/06/2021.
//

import SwiftUI

struct ScoreRow: View {
    
    @EnvironmentObject var teacherController: TeacherState
    @StateObject var scoreVM = ScoreViewModel()
    
    //let score: Score
    let studentID: String
    
    @State private var addingScore: Bool = false
    @State private var resultN: String = ""
    
    var body: some View {
        HStack {
            Text(scoreVM.fullName)
            Spacer()
            if !addingScore {
                if scoreVM.hasScore {
                    Text(String(scoreVM.score.resultN))
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
                    self.scoreVM.addScore(testID: teacherController.currentTest.id, resultNString: resultN)
                    self.addingScore = false
                    self.teacherController.evaluateCurrentTestStatus()
                }
            }
            
        }
        .onAppear {
            self.scoreVM.studentID = studentID
            self.scoreVM.testID = teacherController.currentTest.id
            self.scoreVM.fetchFullName()
            self.scoreVM.fetchScore()
            resultN = String(Int(teacherController.currentTest.outOf / 2 ))
            if scoreVM.hasScore {
                resultN = String(scoreVM.score.resultN)
            }
        }
    }
}
