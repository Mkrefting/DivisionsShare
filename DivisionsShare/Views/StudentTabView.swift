//
//  StudentsTabView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import SwiftUI

struct StudentTabView: View {
    var body: some View {
        TabView{
            TestResultsView()
                .tabItem{
                    Label("Tests", systemImage: "square.and.pencil")
                }
            AnalysisView()
                .tabItem{
                    Label("Analysis", systemImage: "person.3.fill")
                }
        }
    }
}

struct StudentsTabView_Previews: PreviewProvider {
    static var previews: some View {
        StudentTabView()
    }
}
