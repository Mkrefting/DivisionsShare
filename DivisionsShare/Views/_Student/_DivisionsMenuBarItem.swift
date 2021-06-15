//
//  _DivisionMenuBar.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 11/06/2021.
//

import SwiftUI

struct _DivisionsMenuBarItem: View {
    
    @EnvironmentObject var _studentState: _StudentState
    @Binding var joinDivision: Bool

    var body: some View {
        Menu {
            ForEach(_studentState.divisions.sorted(by: { $0.name < $1.name })) { division in
                Button(action: {
                    self._studentState.updateCurrentDivision(division: division)
                    self._studentState.fetchCurrentDivisionTests()
                }) {
                    Text(division.name)
                }
            }
            
            Button(action: {
                self.joinDivision = true
            }) {
                Text("Join Division")
                    .accentColor(.blue) // does not work in SwiftUI atm
            }
        } label: {
            if _studentState.divisionChosen {
                Text(_studentState.currentDivision.name)
            } else {
                Text("Join Division")
            }
        }
    }
}

