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
    @State private var outOf: Int = 25
    @State private var showError: Bool = false

    var body: some View {
        NavigationView {
            VStack{
                
                TextField("Name:", text: $testName)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
            
                Picker("Out of:", selection: $outOf) {
                    ForEach(1...250, id: \.self) {
                        Text("\($0)")
                    }
                }
                
                DatePicker("Date:", selection: $date, displayedComponents: [.date])
                
                if showError {
                    Text("Please give the test a name").foregroundColor(Color.red).padding()
                }
            
                Button(action: {
                    if testName != ""{
                        self.teacherController.addTest(name: testName, date: date, outOf: outOf)
                        self.isOpen = false
                    } else {
                        self.showError = true
                    }
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
