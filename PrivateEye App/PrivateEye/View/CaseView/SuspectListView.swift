//
//  SuspectListView.swift
//  PrivateEye
//
//  Created by Mayank Girdhar on 26/05/21.
//

import SwiftUI
import CoreData

struct SuspectListView: View {
    
    let list: CaseEntity
    let fetchSuspect: FetchRequest<SuspectList>
    
    @State var name = ""
    @State var enterName = ""
    @State var show = false

    
    init(list: CaseEntity) {
        self.list = list
        self.fetchSuspect = FetchRequest<SuspectList>(fetchRequest: PersistenceProvider.default.suspectRequest(for: list))
    }

    var body: some View {
        

        List{
            ForEach(fetchSuspect.wrappedValue){ item in
                HStack{
                    Image(systemName: "person.fill")
                    Spacer()
                    Text(item.suspectName ?? "")
                        .frame(height: 100)
                }
            }
            .onDelete(perform: {indexSet in
                PersistenceProvider.default.delete(fetchSuspect.wrappedValue.get(indexSet))
            })
        }.listStyle(InsetGroupedListStyle())  //LIST
            .navigationBarItems(trailing:
                                    Button(action: {
                alertView()
            }, label: {
                Text("Add")
                if #available(iOS 15.0, *) {
                    Image(systemName: "person.fill.questionmark")
                        .foregroundStyle(.red, .blue)
                } else {
                    // Fallback on earlier versions
                    Image(systemName: "person.fill.questionmark")
                }
                
            })
            )
            .navigationBarTitle("Suspects", displayMode: .inline)
            .navigationViewStyle(StackNavigationViewStyle())
        
    }
    func alertView(){
        let alert = UIAlertController(title: "Suspect Name", message: "Please Enter a Suspect name", preferredStyle: .alert)
        
        alert.addTextField { (pass) in
            pass.isSecureTextEntry = false
            pass.placeholder = "Name..."
        }
        
        let entry = UIAlertAction(title: "Add New", style: .default) { (_) in
            
            enterName = alert.textFields![0].text!
            PersistenceProvider.default.saveSuspect(name: enterName, in: list)
            
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive) { (_) in
            
        }
        
        alert.addAction(cancel)
        alert.addAction(entry)
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: {
            
        })
        
    }
}

