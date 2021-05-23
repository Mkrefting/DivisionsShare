//
//  GeneralView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import SwiftUI

struct GeneralView: View {
    
    @EnvironmentObject var testsController: TestsController

    let division: Division
    
    @State private var addTest: Bool = false

    var body: some View {
                List{
                    ForEach(testsController.tests){ test in
                        HStack{
                            Text(test.name)
                            Spacer()
                            Text(test.dateString)
                        }
                    }
                }
            .navigationViewStyle(StackNavigationViewStyle())
            .onAppear{
                self.testsController.fetchData(divisionID: division.id)
                print("Division ID: \(division.id)")
            }
            .toolbar{
                Button(action: {
                    self.addTest = true
                }, label: {
                    Image(systemName: "plus")
                })
            }
            .sheet(isPresented: $addTest, content: {
                AddTestView(isOpen: $addTest, divisionID: self.division.id)
            })
            .navigationBarTitle("\(division.name) Tests")
    }
}

struct GeneralView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralView(division: Division.example)
    }
}
