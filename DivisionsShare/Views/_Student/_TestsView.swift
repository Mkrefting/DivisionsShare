//
//  _TestsView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 11/06/2021.
//

import SwiftUI

struct _TestsView: View {
    
    @EnvironmentObject var _studentState: _StudentState
    @State private var joinDivision: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                if _studentState.divisionChosen {
                    
                    List {
                        ForEach(_studentState.tests){ test in
                            HStack{
                                Text(test.name)
                                Spacer()
                                Text(test.dateString)
                            }.padding()
                            // add score
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
                            JoinDivisionView(isOpen: $joinDivision)
                        })
                }
            
            }
        }
    }
    
}
