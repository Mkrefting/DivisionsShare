//
//  EditTestView.swift
//  DivisionsShare
//
//  Created by Krefting, Max (PGW) on 06/06/2021.
//

import SwiftUI

struct EditTestView: View {
    
    @EnvironmentObject var teacherState: TeacherState
    @Environment(\.presentationMode) var presentationMode // used when test is deleted

    //@ObservedObject var editTestVM = EditTestViewModel()
    @ObservedObject var testVM: TestViewModel
    
    @Binding var isOpen: Bool
    @State private var testName: String = ""
    @State private var date: Date = Date()
    @State private var outOf: String = ""
    @State private var showError: Bool = false
    
    var body: some View {
        NavigationView {
            VStack{
                
                HStack {
                    Text("Name")
                        .padding()
                    TextField("", text: $testName)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                }
                
                HStack {
                    Text("Out of")
                        .padding()
                    TextField("", text: $outOf)
                        .keyboardType(.decimalPad)
                        //.frame(width: 100, height: nil)
                        //.padding(.all, 5)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                }
                
                DatePicker("Date:", selection: $date, displayedComponents: [.date])
                    .padding()
                
                if showError {
                    Text("Please make sure that the test has a name and a valid maximum mark.").foregroundColor(Color.red).padding()
                }

                Button(action: {
                    if testName != "" && (Int(outOf) != nil){
                        self.testVM.updateTest(name: testName, date: date, outOf: Int(outOf) ?? 0)
                        self.isOpen = false
                    } else {
                        self.showError = true
                    }
                }, label: {
                    Text("Update")
                })
                
                Spacer()
                
                Button(action: {
                    testVM.deleteTest()
                    presentationMode.wrappedValue.dismiss() // close sheet, also need to close test view
                    testVM.closeDueToDelete = false
                }, label: {
                    Text("Delete Test").accentColor(.red)
                })
            }
            .padding()
            .navigationBarTitle(Text("Edit Test"), displayMode: .inline)
            .toolbar{
                Button("Cancel"){
                    self.isOpen = false
                }
            }
            .onAppear {
                //editTestVM.test = teacherState.currentTest
                testName = testVM.test.name
                date = testVM.test.date
                outOf = String(testVM.test.outOf)
            }
        }
    }
}

