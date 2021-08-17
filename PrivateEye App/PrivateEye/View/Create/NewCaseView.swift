//
//  NewCaseView.swift
//  PrivateEye
//
//  Created by Mayank Girdhar on 27/04/21.
//

import SwiftUI

struct NewCaseView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State var typedDescription = ""
    @State var typedName = ""
    @State var caseLocation = ""
    @State var offence = ""
    @State var showingAlert = false
    
    @FetchRequest(fetchRequest: PersistenceProvider.default.caseEntityList) var caseList: FetchedResults<CaseEntity>
    
    @State var toggleNext = false
    @State private var showMediaSheet = false
    var body: some View {
        NavigationView{
//      MARK: - TEXTFIELDS
            Form{
                Section(header: HStack{
                    if #available(iOS 15.0, *) {
                        Image(systemName: "newspaper.fill")
                            .font(.system(size: 22))
                            .foregroundStyle(.red)
                            
                    } else {
                        Image(systemName: "newspaper.fill")
                            .font(.system(size: 22))
                        // Fallback on earlier versions
                    }
                    Text("Enter a Case Name")
                        .fontWeight(.semibold)
                        .font(.system(size: 17))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .fontWeight(.semibold)
                    
                }){
                    TextField("Case Name", text: $typedName)
                }
                Section(header: HStack{
                    if #available(iOS 15.0, *) {
                        Image(systemName: "lineweight")
                            .font(.system(size: 22))
                            .foregroundStyle(.red)
                            
                    } else {
                        Image(systemName: "newspaper.fill")
                            .font(.system(size: 22))
                        // Fallback on earlier versions
                    }
                    Text("Enter a Case Description")
                        .fontWeight(.semibold)
                        .font(.system(size: 17))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .fontWeight(.semibold)
                }){
                    TextField("Case Description", text: $typedName)
                }
                Section(header: HStack{
                    if #available(iOS 15.0, *) {
                        Image(systemName: "person.2.fill")
                            .font(.system(size: 22))
                            .foregroundStyle(.red, .blue)
                            
                    } else {
                        Image(systemName: "newspaper.fill")
                            .font(.system(size: 22))
                        // Fallback on earlier versions
                    }
                    Text("Offence(Optional)")
                        .fontWeight(.semibold)
                        .font(.system(size: 17))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .fontWeight(.semibold)
                        
                }){
                    TextField("Offence...", text: $offence)
                }
                Section(header: HStack{
                    if #available(iOS 15.0, *) {
                        Image(systemName: "location.fill")
                            .font(.system(size: 22))
                            .foregroundStyle(.red)
                            
                    } else {
                        Image(systemName: "newspaper.fill")
                            .font(.system(size: 22))
                        // Fallback on earlier versions
                    }
                    Text("Location(Optional)")
                        .fontWeight(.semibold)
                        .font(.system(size: 17))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .fontWeight(.semibold)
                }){
                    TextField("Location...", text: $caseLocation)
                }
                Section(){
                    HStack {
                        Spacer()
                        Button(action: {
                            let randomInt = arc4random_uniform(10000)
                            let converted = Int64(randomInt)
                            PersistenceProvider.default.createCase(name: typedName, description: typedDescription, caseID: converted, caseLocation: caseLocation, caseOffence: offence)
                            toggleNext = true
                            showingAlert.toggle()
                        }) {
                            
                            HStack {
                                Image(systemName: "square.and.arrow.down.fill")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 22))
                                Text("Save")
                                    .fontWeight(.semibold)
                                    .font(.system(size: 20))
                                
                            }
                    }
                        Spacer()
                    }
                }
            }
            .alert(isPresented: $showingAlert){
                Alert(title: Text("Case Successfully Saved"), message: Text("Add Media now or later in the main Case list"), primaryButton: .destructive(Text("Add Media")){
                    showMediaSheet = true
                }, secondaryButton: .cancel(Text("Later")))
            }
            .sheet(isPresented: $showMediaSheet, content: {
                AddMediaView(list: caseList.first!)
            })
            .navigationTitle("New Case")
            
            Spacer()
//        }
                
        
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
        
        
    }
    
    func buttonTest() -> some View {
        HStack {
            Button(action: {
                let randomInt = arc4random_uniform(10000)
                let converted = Int64(randomInt)
                PersistenceProvider.default.createCase(name: typedName, description: typedDescription, caseID: converted, caseLocation: caseLocation, caseOffence: offence)
                toggleNext = true
                showingAlert.toggle()
            }) {
                
                HStack {
                    Image(systemName: "square.and.arrow.down.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 22))
                    Text("Save")
                        .fontWeight(.semibold)
                        .font(.system(size: 20))
                    
                }
            }
            Spacer()
            if toggleNext{
            Button(action: {
                showMediaSheet = true
                offence.removeAll()
                caseLocation.removeAll()
                typedName.removeAll()
                typedDescription.removeAll()
//                toggleNext.toggle()
            }) {
                HStack {
                    Image(systemName: "photo.on.rectangle.angled")
                        .foregroundColor(.blue)
                        .font(.system(size: 22))
                    Text("Add Media")
                        .fontWeight(.semibold)
                        .font(.system(size: 20))
                    
                }
            }
            }
        }
    }
    

}



struct NewCaseView_Previews: PreviewProvider {
    static var previews: some View {
        NewCaseView()
    }
}
