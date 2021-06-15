//
//  JoinDivisionView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import SwiftUI

struct _JoinDivisionView: View {
    
    @EnvironmentObject var _studentState: _StudentState
    
    @Binding var isOpen: Bool
    @State private var joinCode: String = ""
    @State private var noCodeFound: Bool = false
    
    var body: some View {
        NavigationView {
            VStack{
                
                TextField("Division Join Code:", text: $joinCode)
                    .keyboardType(.decimalPad)
                    .padding()
                
                if noCodeFound {
                    Text("No such division found").foregroundColor(Color.red).padding()
                }

                Button(action: {
                    self._studentState.joinDivision(joinCode: joinCode, handler: {
                        self.isOpen = false
                    })
                    if self.isOpen{
                     self.noCodeFound = true
                    }
                }, label: {
                    Text("Join")
                })
            
            }.padding()
            .navigationBarTitle(Text("Add Division"), displayMode: .inline)
            .toolbar{
                Button("Cancel"){
                    self.isOpen = false
                }
            }
        }
    }
}

struct JoinDivisionView_Previews: PreviewProvider {
    static var previews: some View {
        _JoinDivisionView(isOpen: .constant(true))
    }
}

