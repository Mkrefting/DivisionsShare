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
        VStack {
            HStack{
                Text("Average Test Result:")
                Spacer()
                if vm.nPercentages > 0 {
                    Text(String(Int(vm.totalPercentage/Double(vm.nPercentages)))+"%")
                } else {
                    Text("-")
                }
            }.padding()
            
            HStack{
                Spacer()
                if vm.nFirstAwards > 0 {
                    Text("\(vm.nFirstAwards) 🥇 ")
                    Spacer()
                }
                if vm.nSecondAwards > 0 {
                    Text("\(vm.nSecondAwards) 🥈")
                }
                if vm.nThirdAwards > 0 {
                    Spacer()
                    Text("\(vm.nThirdAwards) 🥉")
                }
                Spacer()
            }
            
        }

        
    }
    
}
