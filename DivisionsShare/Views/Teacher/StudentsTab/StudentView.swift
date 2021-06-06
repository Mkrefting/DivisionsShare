//
//  StudentView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 06/06/2021.
//

import SwiftUI

struct StudentView: View {
    @StateObject var studentVM = StudentViewModel()
    let ID: String
    var body: some View {
        VStack{
            Text(studentVM.fullName)
            Text(studentVM.ID)
        }.onAppear {
            self.studentVM.ID = ID
            self.studentVM.fetchFullName()
        }
    }
}

struct StudentView_Previews: PreviewProvider {
    static var previews: some View {
        StudentView(ID: "preview ID")
    }
}
