//
//  StudentsView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import SwiftUI

struct StudentsView: View {
    var division: Division
    var body: some View {
        List {
            ForEach(division.studentNames, id: \.self) { studentName in
                Text(studentName)
            }
        }
    }
}

struct StudentsView_Previews: PreviewProvider {
    static var previews: some View {
        StudentsView(division: Division.example)
    }
}
