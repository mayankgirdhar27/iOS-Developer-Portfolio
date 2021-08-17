//
//  CaseInfoView.swift
//  PrivateEye
//
//  Created by Mayank Girdhar on 24/05/21.
//

import SwiftUI

struct CaseDetailView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    
    @State var containerHeight: CGFloat = 0 
    
    
    let list: CaseEntity
    
    let fetchedResults: FetchRequest<SavedMediaEntity>
    init(list: CaseEntity) {
        self.list = list
        self.fetchedResults = FetchRequest<SavedMediaEntity>(fetchRequest: PersistenceProvider.default.savedMediaRequest(for: list))
    }
    
    @State var offence = ""
    @State var caseName = ""
    @State var caseDescription = ""
    @State var caseLocation = ""
    @State var enterName = ""
    @State var crimeDate = Date()
    @State var showChangeAlert = false
    @State var toggleCaseList: Bool = true
    @State var toggleDelete: Bool = false
    
    @State private var navigationbarHeight = 0
    @State private var displayDescriptionText: Bool = true
    @State private var displaydescriptionEdit: Bool = false
    
    var body: some View{
        VStack{
            Form{
                Section(){
                    NavigationLink(destination: MediaView(list: list), label: {
                        HStack{
                            Image(systemName: "photo.fill.on.rectangle.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.blue)
                                .padding(.leading, 10)
                            Spacer()
                            VStack{
                                Text("Digital Evidence")
                                    .font(.system(size: 22, weight: .bold, design: .rounded))

                                Text("\(count()) Photos & Videos")
                                    .font(.system(size: 18, weight: .medium, design: .rounded))
                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                            }
                            Spacer()
                        }.padding()
//                        MediaButton(list: list)
                        
                    })
                }
                Section(header: HStack {
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 22))
                    Text("Details")
                    
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    
                        .fontWeight(.semibold)
                    
                }){
                    HStack{
                        Group{
                            if #available(iOS 15.0, *) {
                                Image(systemName: "text.badge.star")
                                    .font(.system(size: 22))
                                    .foregroundStyle(.red, .blue)
                            } else {
                                // Fallback on earlier versions
                                Image(systemName: "text.badge.star")
                                    .font(.system(size: 22))
                                    .foregroundColor(.blue)
                            }
                                
                            Text("Case Name:")
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                            CustomTextField(placeholder: Text("\(list.caseName ?? "")"), text: $caseName)
                                
                        }
                    } //Case Name
                    HStack{
                        Group{
                            if #available(iOS 15.0, *) {
                                Image(systemName: "person.crop.circle.badge.exclamationmark.fill")
                                    .font(.system(size: 22))
                                    .foregroundStyle(.red, .blue)
                            } else {
                                // Fallback on earlier versions
                                Image(systemName: "person.crop.circle.badge.exclamationmark.fill")
                                    .font(.system(size: 22))
                            }
                            Text("Offence:")
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                            CustomTextField(placeholder: Text("\(list.offence ?? "")"), text: $offence)
                                
                        }
                    } //Offence
                    HStack {
                        Group{
                            if #available(iOS 15.0, *) {
                                Image(systemName: "location.fill.viewfinder")
                                    .font(.system(size: 22))
                                    .foregroundStyle(.red, .blue)
                            } else {
                                Image(systemName: "location.fill.viewfinder")
                                    .font(.system(size: 22))
                                    .foregroundColor(.blue)
                                // Fallback on earlier versions
                            }
                            Text("Location:")
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                            CustomTextField(placeholder: Text("\(list.location ?? "")"), text: $caseLocation)
                                
                        }
                    } //Location
                    HStack {
                        Group{
                            if #available(iOS 15.0, *) {
                                Image(systemName: "square.and.pencil")
                                    .font(.system(size: 22))
                                    .foregroundStyle(.red, .blue)
                            } else {
                                Image(systemName: "square.and.pencil")
                                    .font(.system(size: 22))
                                    .foregroundColor(.blue)
                                // Fallback on earlier versions
                            }
                            Text("Description:")
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
//                            if displayDescriptionText{
//                                if ((list.caseDescription?.isEmpty) != nil){
//                                    Text("Tap to add description")
//                                }
//                                Text("\(list.caseDescription ?? "")").onTapGesture {
//                                    displayDescriptionText = false
//                                    displaydescriptionEdit = true
//                                }
//                            }
//                            if displaydescriptionEdit{
                                CustomTextField(placeholder: Text("\(list.caseDescription ?? "")"), text: $caseDescription)
//                            }
                        }
                    } //Description
                    //                    DatePicker("Crime Date", selection: $crimeDate, displayedComponents: .date)
                    HStack {
                        Spacer()
                        Button(action: {
                            if caseName.isEmpty{
                                caseName = list.caseName ?? ""
                                PersistenceProvider.default.editCaseName(list, change: caseName)
                            } else if !caseName.isEmpty{
                                PersistenceProvider.default.editCaseName(list, change: caseName)
                            }
                            if caseDescription.isEmpty{
                                caseDescription = list.caseDescription ?? ""
                                PersistenceProvider.default.editCaseDescription(list, change: caseDescription)
                            } else if !caseDescription.isEmpty{
                                PersistenceProvider.default.editCaseDescription(list, change: caseDescription)
                            }
                            if caseLocation.isEmpty{
                                caseLocation = list.location ?? ""
                                PersistenceProvider.default.editCaseLocation(list, change: caseLocation)
                            } else if !caseLocation.isEmpty{
                                PersistenceProvider.default.editCaseLocation(list, change: caseLocation)
                            }
                            if offence.isEmpty {
                                offence = list.offence ?? ""
                                PersistenceProvider.default.editOffence(list, change: offence)
                            } else if !offence.isEmpty {
                                PersistenceProvider.default.editOffence(list, change: offence)
                            }
                            displayDescriptionText = true
                            displaydescriptionEdit = false
                            
                            
                            
                        }, label: {
                            HStack{
                                Text("Save").fontWeight(.semibold)
                                Image(systemName: "square.and.arrow.down.on.square")
                                    .font(.system(size: 20))
                            }
                        })
                        Spacer()
                    } //Save
                }
                Section(){
                    NavigationLink(destination: NoteView(list: list), label: {
                        if #available(iOS 15.0, *) {
                            Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                .foregroundStyle(.red, .blue)
                        } else {
                            Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                .foregroundColor(.blue)
                            // Fallback on earlier versions
                        }
                        Text("Note")
                            .fontWeight(.semibold)
                    })
                    //MARK: - SuspectList
                    NavigationLink(destination: SuspectListView(list: list), label: {
                        if #available(iOS 15.0, *) {
                            Image(systemName: "person.fill.viewfinder")
                                .foregroundStyle(.red, .blue)
                                .font(.system(size: 22))
                        } else {
                            // Fallback on earlier versions
                            Image(systemName: "person.fill.viewfinder")
                                .font(.system(size: 22))
                        }
                        Text("Suspect List")
                            .fontWeight(.semibold)
                        
                    })
                }
                Section(header: HStack {
                    if #available(iOS 15.0, *) {
                        Image(systemName: "calendar.badge.clock")
                            .font(.system(size: 22))
                            .foregroundStyle(.red, .blue)
                    } else {
                        Image(systemName: "calendar.badge.clock")
                            .font(.system(size: 22))
                        // Fallback on earlier versions
                    }
                    Text("Date & Time of Crime Commited")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .fontWeight(.semibold)
                }){
                    HStack{
                        Text("Crime Date")
                        Text("\(list.crimeCommitedDate ?? Date())")
                            .fontWeight(.light)
                            .font(.system(size: 15))
                    }
                    DatePicker("Select Date", selection: $crimeDate)
                    Button(action: {
                        showChangeAlert = true
                        //                        PersistenceProvider.default.editDate(list, dateChange: crimeDate)
                    }, label: {
                        Text("Change Date")
                    })
                    
                }
            }.frame(height: UIScreen.main.bounds.height-140)
            
            .alert(isPresented: $showChangeAlert){
                Alert(title: Text("Change Crime Date"), message:
                        Text("Are you sure you want to change the date & time to? \n  \(crimeDate)"),
                      primaryButton: .destructive(Text("Save")){
                    PersistenceProvider.default.editDate(list, dateChange: crimeDate)
                }, secondaryButton: .cancel())
                
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("Case Information", displayMode: .inline)
        }
    }
    func count() -> Int{
        let totalCount = fetchedResults.wrappedValue.count
        return totalCount
    }
    
    
    
    
    
}

