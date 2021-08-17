//
//  ContentView.swift
//  PrivateEye
//
//  Created by Mayank Girdhar on 27/04/21.
//

import SwiftUI

struct ContentView: View {
    
    
    @FetchRequest(fetchRequest: PersistenceProvider.default.caseEntityList) var caseList: FetchedResults<CaseEntity>
    
    @FetchRequest(fetchRequest: PersistenceProvider.default.requestPassword) var passCode: FetchedResults<Password>
    
    @State var newCaseSheet = false
    
    @State var status = false // change this back to false

    
    var body: some View {
        VStack{
            if status{
                TabView{
                    if !caseList.isEmpty{
                    CaseView()
                        .tabItem {
                            Image(systemName: "doc.text.magnifyingglass")
                            Text("Cases")
                        }
                    }
                    NewCaseView()
                        .tabItem {
                            Image(systemName: "plus.viewfinder")
                            Text("New Case")
                        }
//                    AboutView()
//                        .tabItem {
//                            Image(systemName: "info.circle")
//                            Text("About")
//                        }
                        .animation(.spring())
                }
            }else{
                if passCode.isEmpty{
                    OnPassCodeView()
                }else{
                    PassCodeView()
                }
            }
        }
        .onAppear(){
            NotificationCenter.default.addObserver(forName: NSNotification.Name("Success"), object: nil, queue: .main) { (_) in
                self.status = true
            }
        }
        
        //    .animation(.spring())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

