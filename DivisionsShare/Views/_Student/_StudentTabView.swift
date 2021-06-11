//
//  StudentsTabView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import SwiftUI

struct _StudentTabView: View {
    var body: some View {
        TabView{
            _TestsView()
                .tabItem{
                    Label("Tests", systemImage: "square.and.pencil")
                }
        }
    }
}

