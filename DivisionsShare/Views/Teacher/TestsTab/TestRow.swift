//
//  TestDetailsView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 04/06/2021.
//

import SwiftUI

struct TestRow: View {
    let test: Test
    var body: some View {
        HStack{
            Text(test.name).foregroundColor(test.allScoresEntered ? .green : .red)
            Spacer()
            Text(test.dateString)
        }.padding()
    }
}
