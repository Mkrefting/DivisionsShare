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
        NavigationView{
            VStack{
                List{
                    ForEach(testsController.tests){ test in
                        HStack{
                            Text(test.name)
                            Spacer()
                            Text(test.dateString)
                        }
                    }
                }
            }
            .navigationBarTitle("\(division.name) Tests")
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
        }
    }
}

struct GeneralView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralView(division: Division.example)
    }
}
