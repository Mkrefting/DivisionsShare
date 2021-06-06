//
//  StudentRow.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 06/06/2021.
//

import SwiftUI

struct StudentRow: View {
    @StateObject var studentVM = StudentViewModel()
    let ID: String
    var body: some View {
        VStack{
            Text(studentVM.fullName)
        }.onAppear {
            self.studentVM.ID = ID
            self.studentVM.fetchFullName()
        }
    }
}

struct StudentRow_Previews: PreviewProvider {
    static var previews: some View {
        StudentRow(ID: "preview ID")
    }
}
