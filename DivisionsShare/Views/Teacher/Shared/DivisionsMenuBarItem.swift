//
//  DivisionsMenuBarItem.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 05/06/2021.
//

import SwiftUI

struct DivisionsMenuBarItem: View {
    
    @EnvironmentObject var teacherState: TeacherState
    @Binding var addDivision: Bool

    var body: some View {
        Menu {
            ForEach(teacherState.divisions.sorted(by: { $0.name < $1.name })) { division in
                Button(action: {
                    self.teacherState.updateCurrentDivision(division: division)
                    self.teacherState.fetchCurrentDivisionTests()
                }) {
                    Text(division.name)
                }
            }
            
            Button(action: {
                self.addDivision = true
            }) {
                Text("Add Division")
                    .accentColor(.blue) // does not work in SwiftUI atm
            }
        } label: {
            if teacherState.divisionChosen {
                Text(teacherState.currentDivision.name)
            } else {
                Text("Add Division")
            }
        }
    }
}
