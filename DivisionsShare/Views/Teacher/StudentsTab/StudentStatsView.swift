//
//  StudentStatsView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 15/06/2021.
//

import SwiftUI

struct StudentStatsView: View {
    
    @ObservedObject var vm: StudentViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading){
                if vm.nPercentages > 0 {
                    Text("Average Score")
                    Text(String(Int(vm.totalPercentage/Double(vm.nPercentages)))+"%").bold()
                } else {
                    Text("No scores")
                }
            }.padding()
            Spacer()
            if vm.nFirstAwards > 0 {
                Text("\(vm.nFirstAwards) 🥇").padding()
            }
            if vm.nSecondAwards > 0 {
                Text("\(vm.nSecondAwards) 🥈").padding()
            }
            if vm.nThirdAwards > 0 {
                Text("\(vm.nThirdAwards) 🥉").padding()
            }
        
        }

        
    }
    
}
