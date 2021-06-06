//
//  AddTestView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 23/05/2021.
//

import SwiftUI

struct AddTestView: View {
    
    @EnvironmentObject var teacherState: TeacherState
    @Binding var isOpen: Bool
    @State private var testName: String = ""
    @State private var date: Date = Date()
    @State private var outOf: String = ""
    @State private var showError: Bool = false

    var body: some View {
        NavigationView {
            VStack{
                
                TextField("Name:", text: $testName)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                
                TextField("Out of:", text: $outOf)
                    .keyboardType(.decimalPad)
                    //.frame(width: 100, height: nil)
                    //.padding(.all, 5)
                    .padding()
                    .background(Color(.secondarySystemBackground))
            
                DatePicker("Date:", selection: $date, displayedComponents: [.date])
                    .padding()
                
                if showError {
                    Text("Please make sure that the test has a name and a valid maximum mark.").foregroundColor(Color.red).padding()
                }

                Button(action: {
                    if testName != "" && (Int(outOf) != nil){
                        self.teacherState.addTest(name: testName, date: date, outOf: Int(outOf) ?? 100)
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
        }
    }
}

struct AddTestView_Previews: PreviewProvider {
    static var previews: some View {
        AddTestView(isOpen: .constant(true))
    }
}
