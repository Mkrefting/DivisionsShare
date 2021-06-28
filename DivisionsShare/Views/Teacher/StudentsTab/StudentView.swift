//
//  StudentView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 06/06/2021.
//

import SwiftUI

struct StudentView: View {
    
    @EnvironmentObject var teacherState: TeacherState
    @StateObject var studentVM = StudentViewModel()
    @State private var showRemoveStudentPrompt: Bool = false
    @Environment(\.presentationMode) var presentationMode // used when student is removed from div

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
        .toolbar{
        
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    self.showRemoveStudentPrompt = true
                }, label: {
                    Label("", systemImage: "trash")
                })
            }
        }
        .onAppear {
            self.studentVM.ID = ID
            self.studentVM.divisionID = teacherState.currentDivision.id
            self.studentVM.fetchFullName()
            self.studentVM.fetchScores()
            self.studentVM.fetchAwardsStats()
        }
        .alert(isPresented: $showRemoveStudentPrompt){
            Alert(title: Text("Are you sure you want to remove this student from the division?"), primaryButton: .default(Text("Yes")) {
                studentVM.removeFromDivision()
                if let index = teacherState.currentDivision.studentIDs.firstIndex(of: ID) {
                    teacherState.currentDivision.studentIDs.remove(at: index)
                }
                presentationMode.wrappedValue.dismiss() // close student view
            }, secondaryButton: .cancel(Text("No")))
        }
    }
}

struct StudentView_Previews: PreviewProvider {
    static var previews: some View {
        StudentView(ID: "preview ID")
    }
}
