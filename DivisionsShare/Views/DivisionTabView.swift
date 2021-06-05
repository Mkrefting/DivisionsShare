//
//  DivisionTabView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import SwiftUI

struct DivisionTabView: View {
    
    @EnvironmentObject var teacherController: TeacherController
    
    var body: some View {
        TabView{
            TestsView()
                .tabItem{
                    Label("Tests", systemImage: "square.and.pencil")
                }
            StudentsView(division: Division.example)
                .tabItem{
                    Label("Students", systemImage: "person.3.fill")
                }
        }.onAppear {
            self.teacherController.fetchData()
        }
    }
}

struct DivisionTabView_Previews: PreviewProvider {
    static var previews: some View {
        DivisionTabView()
    }
}

