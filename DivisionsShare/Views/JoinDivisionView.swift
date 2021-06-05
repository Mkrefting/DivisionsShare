//
//  JoinDivisionView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import SwiftUI

struct JoinDivisionView: View {
    @EnvironmentObject var studentController: StudentController
    
    @Binding var isOpen: Bool
    @State private var joinCode: String = ""
    @State private var noCodeFound: Bool = false
    
    var body: some View {
        VStack{
            if noCodeFound {
                Text("No such division found").bold()
            }
            TextField("Division Join Code:", text: $joinCode).padding()

            Button(action: {
                self.studentController.joinDivision(joinCode: joinCode, handler: {
                    self.isOpen = false
                })
                if self.isOpen{
                 self.noCodeFound = true
                }
            }, label: {
                Text("Submit")
            })
        }
    }
}

struct JoinDivisionView_Previews: PreviewProvider {
    static var previews: some View {
        JoinDivisionView(isOpen: .constant(true))
    }
}
