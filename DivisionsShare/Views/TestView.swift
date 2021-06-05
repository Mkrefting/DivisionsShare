//
//  TestView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 04/06/2021.
//

import SwiftUI

struct TestView: View {
    let test: Test
    var body: some View {
        Text("test view here, add test results, view individual results")
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(test: Test.example)
    }
}
