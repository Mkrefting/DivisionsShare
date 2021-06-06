//
//  DivisionTabView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import SwiftUI

struct TeacherTabView: View {
    
    @EnvironmentObject var teacherState: TeacherState
    
    var body: some View {
        TabView{
            TestsView()
                .tabItem{
                    Label("Tests", systemImage: "square.and.pencil")
                }
            StudentsView()
                .tabItem{
                    Label("Students", systemImage: "person.3.fill")
                }
        }.onAppear {
            self.teacherState.fetchData()
        }
    }
}

