//
//  DivisionsView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import SwiftUI

struct DivisionsView: View {
    
    @EnvironmentObject var authController: AuthController
    
    @EnvironmentObject var divisionsController: DivisionsController
    
    @State private var addDivision: Bool = false
    
    /*init(){
        divisionsState.fetchData()
    }*/
    
    var body: some View {
        NavigationView{
            List{
                ForEach(divisionsController.divisions){ division in
                    NavigationLink(destination: DivisionTabView(division: division)){
                        Text(division.name)
                    }
                }
            }
            .toolbar{
                HStack{
                    Button(action: {
                        authController.signOut()
                    }, label: {
                        Text("Sign Out")
                    })
                    Spacer()
                    Button(action: {
                        self.addDivision = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
            .navigationBarTitle("Divisions")
            .navigationViewStyle(StackNavigationViewStyle())
            .sheet(isPresented: $addDivision, content: {
                AddDivisionView(isOpen: $addDivision)
            })
            .onAppear{
                self.divisionsController.fetchData()
                print("User Id: \(divisionsController.user?.uid ?? "")")
            }


        }
    }
}

struct DivisionsView_Previews: PreviewProvider {
    static var previews: some View {
        DivisionsView()
    }
}
