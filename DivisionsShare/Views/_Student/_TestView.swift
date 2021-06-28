//
//  _TestView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 28/06/2021.
//

import SwiftUI

struct AwardView: View {
    let award: String
    var body: some View {
        if award == "first" {
            Text("🥇")
        } else if award == "second" {
            Text("🥈")
        } else if award == "third" {
            Text("🥉")
        }
    }
}

struct _TestView: View {
    
    @EnvironmentObject var _studentState: _StudentState
    @StateObject var _testVM = _TestViewModel()

    let test: Test
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text(test.name)
                Spacer()
                Text(test.dateString).font(.caption)
            }
            Spacer()
            AwardView(award: _testVM.award)
            Spacer()
            if self._testVM.score.resultN != -1 { // i.e. if there is no score, and current score is just static 'blank'
                VStack(alignment: .leading) {
                    Text(String(self._testVM.score.resultN)).bold()
                    Text("/ \(String(self._testVM.test.outOf))").font(.caption)
                }
            } else {
                Text("-")
            }

        }.padding()
        .onAppear {
            self._testVM.studentID = self._studentState.id
            self._testVM.testID = self.test.id
            self._testVM.fetchData()
        }
    }

}
