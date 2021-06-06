//
//  AddDivisionView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import SwiftUI

struct AddDivisionView: View {
    
    @EnvironmentObject var teacherState: TeacherState
    
    @Binding var isOpen: Bool
    @State private var showError: Bool = false
    @State private var divisionName: String = ""
    
    var body: some View {
        NavigationView{
            VStack{
                
                TextField("Division Name:", text: $divisionName)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                
                if showError {
                    Text("You already have a division with this name!").foregroundColor(Color.red).padding()
                }
            
                
                Button(action: {
                    self.showError = !self.teacherState.addDivision(name: divisionName)
                    if !self.showError {
                        self.isOpen = false
                    }
                }, label: {
                    Text("Add")
                })
                
                
            }
            .padding()
            .navigationBarTitle(Text("Add Division"), displayMode: .inline)
            .toolbar{
                Button("Cancel"){
                    self.isOpen = false
                }
            }
        }
    }
}

struct AddDivisionView_Previews: PreviewProvider {
    static var previews: some View {
        AddDivisionView(isOpen: .constant(true))
    }
}
