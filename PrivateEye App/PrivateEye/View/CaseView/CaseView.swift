//
//  CaseView.swift
//  PrivateEye
//
//  Created by Mayank Girdhar on 27/04/21.
//

import SwiftUI

struct CaseView: View {
    
    
    @State var toggleCaseList: Bool = true
    @State var toggleDelete: Bool = false
    
    @FetchRequest(fetchRequest: PersistenceProvider.default.caseEntityList) var allLists: FetchedResults<CaseEntity>
    @FetchRequest(entity: CaseEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \CaseEntity.date, ascending: true)]) var oldest: FetchedResults<CaseEntity>
    @State var newCaseSheet = false
    
    
    @State private var searchText = ""
    
    @State var changePasscodeSheet = false
    @State var filterCase: Bool = false
    @State var filderName: Bool = false
    @State var filterId = 0
    
    @State var dateSort = true
    @State var dateSortLogo = false
    var body: some View{
        NavigationView{
            VStack {
                if toggleDelete{
                    VStack{
                    HStack{
                        Spacer()
                        Button(action: {
                            toggleDelete = false
                            toggleCaseList = true
                        }, label: {Text("Done")}).font(.system(size: 22)).padding()
                    }
                    DeleteViewCase()
                }
                }
                if toggleCaseList{
                    VStack{
                        SearchIdBar(inputNumber: $searchText)
                        let convertedString = Int64(searchText)
                        List((dateSort == true ? allLists : oldest).filter(({searchText.isEmpty ? true : $0.caseID.checkID(checkNum: convertedString!)}))){ item in
                                NavigationLink(destination: CaseDetailView(list: item)){
                                    HStack {
                                        VStack{
                                            HStack {
                                                Text("Case ID: \(item.caseID)").font(.title3).fontWeight(.semibold)
                                                Spacer()
                                            }
                                            HStack {
                                                Text("Name: \(item.caseName ?? "")")
                                                Spacer()
                                            }
                                            HStack{
                                                Text("Description: \(item.caseDescription ?? "")")
                                                    .fontWeight(.light)
                                                Spacer()
                                            }
                                            HStack{
                                                Text("Date: \(item.date ?? Date())").font(.footnote)
                                                    .fontWeight(.thin)
                                                Spacer()
                                            }
                                        }
                                    }
                                    
                                } //Navigation Link
                        }
                    }
                }
                


            }
            .sheet(isPresented: $changePasscodeSheet, content: {
                ChangeCodeView()
            })
            
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Cases")
        

            
        .toolbar(content: {
            ToolbarItem(placement: .primaryAction){
                Menu {
                    Section(header: Text("Sort Date")) {
                        Button(action: {
                            dateSort.toggle()
                            dateSortLogo.toggle()})
                    {
                        Label("Date",
                    systemImage:
                    dateSort == true ?
                    "chevron.down.square.fill" : "chevron.up.square.fill")}}
                    Section {Button(action: {
                                toggleDelete = true
                                toggleCaseList = false})
                        {Label("Delete Mode", systemImage: "xmark")}}
                    Section(header: Text("Change Password")) {
                        Button(action: {changePasscodeSheet = true})
                        {Label("Change Password", systemImage: "lock.shield")}
                    }
                }
                label: {Image(systemName: "gear").font(.system(size: 18))
                        Text("Options")}
            }
        })
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    func checkID(num: Int64, checkNum: Int64) -> Bool {
        let conNum = String(num)
        let conCheck = String(checkNum)
        var resultBool = false
        if conNum.first == conCheck.first{
            resultBool = true
        }
        return resultBool
    }
    
}

// The structure was taken from an article on internet
// The link is "https://www.appcoda.com/swiftui-search-bar/"
struct SearchIdBar: View {
    @Binding var inputNumber: String
    @State var isEditing = false
    var body: some View {
        HStack {
            TextField("Search ...", text: $inputNumber)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        if isEditing {
                            Button(action: {
                                self.inputNumber = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.inputNumber = ""
                    
                    // Dismiss the keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}

extension Int64{
    func checkID(checkNum: Int64) -> Bool {
        var resultBool = false
        let string = String(self)
        let conCheck = String(checkNum)
        if  string.contains(conCheck){
            resultBool = true
        }
        return resultBool
    }
}
