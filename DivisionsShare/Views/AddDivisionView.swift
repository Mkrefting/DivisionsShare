//
//  AddDivisionView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import SwiftUI

struct AddDivisionView: View {
    
    @EnvironmentObject var divisionsController: DivisionsController
    
    @Binding var isOpen: Bool
    @State private var divisionName: String = ""
    
    var body: some View {
        VStack{
            
            TextField("Division Name:", text: $divisionName).padding()
        
            Button(action: {
                self.divisionsController.addDivision(name: divisionName)
                self.isOpen = false
            }, label: {
                Text("Submit")
            })
        }
    }
}

struct AddDivisionView_Previews: PreviewProvider {
    static var previews: some View {
        AddDivisionView(isOpen: .constant(true))
    }
}
