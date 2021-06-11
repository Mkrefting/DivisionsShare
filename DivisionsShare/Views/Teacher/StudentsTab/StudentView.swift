//
//  StudentView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 06/06/2021.
//

import SwiftUI

struct StudentScoreRow: View {
    
    @StateObject var scoreVM = ScoreViewModel()
    
    let score: Score
    let testID: String
    
    var body: some View {
        
        HStack{
            Text(scoreVM.test.name)
            Spacer()
            Text(String(score.resultN)+" / "+String(scoreVM.test.outOf))
        }
        .onAppear {
            scoreVM.testID = testID
            scoreVM.getTest()
        }
    }
    
}


struct StudentStatsView: View {
    
    @ObservedObject var vm: StudentViewModel

    var body: some View {
        
        HStack{
            Text("Average Percentage:")
            Spacer()
            if vm.nPercentages > 0 {
                Text(String(Int(vm.totalPercentage/Double(vm.nPercentages)))+"%")
            } else {
                Text("-")
            }
        }.padding()
        
    }
    
}

struct StudentView: View {
    
    @EnvironmentObject var teacherState: TeacherState
    @StateObject var studentVM = StudentViewModel()
    let ID: String
    
    var body: some View {
        VStack{
            StudentStatsView(vm: studentVM)
            
            List {
                ForEach(studentVM.scores){ score in
                    StudentScoreRow(score: score, testID: score.testID)
                }
            }
            .listStyle(InsetGroupedListStyle())

        }
        .navigationBarTitle(studentVM.fullName, displayMode: .inline)
        .onAppear {
            self.studentVM.ID = ID
            self.studentVM.divisionID = teacherState.currentDivision.id
            self.studentVM.fetchFullName()
            self.studentVM.fetchScores()
            //self.studentVM.fetchStats()
        }
    }
}

struct StudentView_Previews: PreviewProvider {
    static var previews: some View {
        StudentView(ID: "preview ID")
    }
}
