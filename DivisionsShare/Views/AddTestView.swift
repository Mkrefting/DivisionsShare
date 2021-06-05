//
//  AddTestView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import SwiftUI

struct AddTestView: View {
    
    @EnvironmentObject var teacherController: TeacherController
    @Binding var isOpen: Bool
    @State private var testName: String = ""
    @State private var date: Date = Date()

    var body: some View {
        NavigationView {
            VStack{
                TextField("Name:", text: $testName)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
            
                DatePicker("Date:", selection: $date, displayedComponents: [.date])
                
                Button(action: {
                    self.teacherController.addTest(name: testName, date: date)
                    self.isOpen = false
                }, label: {
                    Text("Submit")
                })
            }
            .padding()
            .navigationBarTitle(Text("Add Test"), displayMode: .inline)
            .toolbar{
                Button("Cancel"){
                    self.isOpen = false
                }
            }
            .onAppear {
                print("Showing add test view")
            }
        }
    }
}

struct AddTestView_Previews: PreviewProvider {
    static var previews: some View {
        AddTestView(isOpen: .constant(true))
    }
}
