//
//  _TestsView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 11/06/2021.
//

import SwiftUI

struct _DivStatsView: View {
    
    @EnvironmentObject var _studentState: _StudentState
    @StateObject var vm = StudentViewModel()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                if vm.nPercentages > 0 {
                    Text("Average Score")
                    Text(String(Int(vm.totalPercentage/Double(vm.nPercentages)))+"%").bold()
                }
            }.padding()
            Spacer()
            if vm.nFirstAwards > 0 {
                Text("\(vm.nFirstAwards) 🥇").padding()
            }
            if vm.nSecondAwards > 0 {
                Text("\(vm.nSecondAwards) 🥈").padding()
            }
            if vm.nThirdAwards > 0 {
                Text("\(vm.nThirdAwards) 🥉").padding()
            }
        }.onAppear {
            self.vm.ID = _studentState.id
            self.vm.divisionID = _studentState.currentDivision.id
            self.vm.fetchScores()
            self.vm.fetchAwardsStats()
        }
    }
    
}

struct _TestsView: View {
    
    @EnvironmentObject var authState: AuthState
    @EnvironmentObject var _studentState: _StudentState
    @State private var joinDivision: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                if _studentState.divisionChosen {
                    
                    _DivStatsView()
                    
                    List {
                        ForEach(_studentState.tests){ test in
                            _TestView(test: test)
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    
                } else {
                    Text("No Division Selected")
                }
                
            }
            //.navigationBarTitle("Tests", displayMode: .inline)
            .navigationBarTitle("Tests")

            .toolbar{
                
                ToolbarItem(placement: .navigationBarLeading) {
                    _DivisionsMenuBarItem(joinDivision: $joinDivision)
                        .sheet(isPresented: $joinDivision, content: {
                            _JoinDivisionView(isOpen: $joinDivision)
                        })
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        authState.signOut()
                    }) {
                        Text("Sign Out").font(.caption)
                    }
                }
            
            }
        }
    }
    
}
