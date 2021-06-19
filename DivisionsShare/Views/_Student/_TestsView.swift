//
//  _TestsView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 11/06/2021.
//

import SwiftUI

struct _TestView: View {
    
    @EnvironmentObject var _studentState: _StudentState
    @StateObject var _testVM = _TestViewModel()

    let test: Test
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text(test.name)
                Spacer()
                Text(test.dateString).font(.caption)
            }
            Spacer()
            if self._testVM.score.resultN != -1 { // i.e. if there is no score, and current score is just static 'blank'
                VStack(alignment: .leading) {
                    Text(String(self._testVM.score.resultN)).bold()
                    Text("/ \(String(self._testVM.test.outOf))").font(.caption)
                }
            } else {
                Text("-")
            }

        }.padding()
        .onAppear {
            self._testVM.studentID = self._studentState.id
            self._testVM.testID = self.test.id
            self._testVM.fetchData()
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
            .navigationBarTitle("Tests", displayMode: .inline)
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
