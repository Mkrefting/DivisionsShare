//
//  StudentsTabView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import SwiftUI

struct _StudentTabView: View {

    @EnvironmentObject var _studentState: _StudentState

    var body: some View {
        TabView{
            _TestsView()
                .tabItem{
                    Label("Tests", systemImage: "square.and.pencil")
                }
        }.onAppear {
            self._studentState.fetchData()
        }
    }
}

