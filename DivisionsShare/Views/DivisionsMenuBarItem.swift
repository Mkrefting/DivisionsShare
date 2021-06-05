//
//  DivisionsMenuBarItem.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 05/06/2021.
//

import SwiftUI

struct DivisionsMenuBarItem: View {
    
    @EnvironmentObject var teacherController: TeacherController
    @Binding var addDivision: Bool

    var body: some View {
        Menu {
            ForEach(teacherController.divisions.sorted(by: { $0.name < $1.name })) { division in
                Button(action: {
                    self.teacherController.updateCurrentDivision(division: division)
                    self.teacherController.fetchCurrentDivisionTests()
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
            if teacherController.divisionChosen {
                Text(teacherController.currentDivision.name)
            } else {
                Text("Choose Division")
            }
        }
    }
}
