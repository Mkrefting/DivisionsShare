//
//  DivisionsView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//
/*
import SwiftUI

struct DivisionsView: View {
    
    @EnvironmentObject var authController: AuthController
    @EnvironmentObject var divisionsController: DivisionsController
    @State private var addDivision: Bool = false

    var body: some View {
        NavigationView{
            List{
                ForEach(divisionsController.divisions){ division in
                    NavigationLink(destination: DivisionTabView(division: division)){
                        VStack(alignment: .leading) {                            Text(division.name)
                                .font(.headline)
                            Spacer()
                            HStack{
                                Text("\(division.studentIDs.count)")
                                Image(systemName: "person.3")
                                    .renderingMode(.original)
                                Spacer()
                                Text("Join Code: \(division.joinCode)")
                            }.font(.caption)

                        }.padding()
                    }
                }
            }
            //.navigationViewStyle(StackNavigationViewStyle())

            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        authController.signOut()
                    }, label: {
                        Text("Sign Out")
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.addDivision = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
            .navigationBarTitle(Text("Your Divisions"), displayMode: .inline)
            .sheet(isPresented: $addDivision, content: {
                AddDivisionView(isOpen: $addDivision)
            })
            .onAppear{
                self.divisionsController.fetchData()
            }


        }
    }
}

struct DivisionsView_Previews: PreviewProvider {
    static var previews: some View {
        DivisionsView()
    }
}
*/
