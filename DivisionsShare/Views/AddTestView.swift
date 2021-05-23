//
//  AddTestView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import SwiftUI

struct AddTestView: View {
    
    @EnvironmentObject var testsController: TestsController
    @Binding var isOpen: Bool
    let divisionID: String
    @State private var testName: String = ""
    
    var body: some View {
        VStack{
            
            TextField("Test Name:", text: $testName).padding()
        
            Button(action: {
                self.testsController.addTest(name: testName, divisionID: divisionID)
                self.isOpen = false
            }, label: {
                Text("Submit")
            })
        }
    }
}

struct AddTestView_Previews: PreviewProvider {
    static var previews: some View {
        AddTestView(isOpen: .constant(true), divisionID: "test div id")
    }
}
