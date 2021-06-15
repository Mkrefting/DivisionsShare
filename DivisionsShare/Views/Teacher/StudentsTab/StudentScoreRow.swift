//
//  StudentScoreRow.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 15/06/2021.
//

import SwiftUI

struct StudentScoreRow: View {
    
    @StateObject var scoreVM = ScoreViewModel()
    
    let score: Score
    let testID: String
    
    var body: some View {
        
        HStack{
            Text(scoreVM.test.name)
            Spacer()
            Text(String(score.resultN)+" / "+String(scoreVM.test.outOf))
        }
        .onAppear {
            scoreVM.testID = testID
            scoreVM.getTest()
        }
    }
    
}

