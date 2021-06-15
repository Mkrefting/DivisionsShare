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
        
        HStack{
            Text("Average Test Result:")
            Spacer()
            if vm.nPercentages > 0 {
                Text(String(Int(vm.totalPercentage/Double(vm.nPercentages)))+"%")
            } else {
                Text("-")
            }
        }.padding()
        
    }
    
}
