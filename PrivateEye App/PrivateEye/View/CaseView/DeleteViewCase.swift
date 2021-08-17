//
//  DeleteViewCase.swift
//  PrivateEye
//
//  Created by Mayank Girdhar on 18/06/2021.
//

import SwiftUI

struct DeleteViewCase: View {
    
    @FetchRequest(fetchRequest: PersistenceProvider.default.caseEntityList) var caseList: FetchedResults<CaseEntity>
    
    var body: some View {
        List{
            HStack{
                Spacer()
                Text("Swipe left to delete")
                Image(systemName: "arrow.left")
                Spacer()
            }
            
            if !caseList.isEmpty{
                ForEach(caseList){ item in
                    VStack{
                        HStack{
                            Text("Case ID: \(item.caseID)")
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        HStack{
                            Text("Case Name: \(item.caseName ?? "")").font(.system(size: 20))
                            Spacer()
                        }
                    }
                }.onDelete(perform: { indexSet in
                    PersistenceProvider.default.deleteCase(caseList.get(indexSet))
                    
                })
            }else if caseList.isEmpty{
                Text("Currently There are no Cases")
            }
        }.listStyle(InsetGroupedListStyle())
            .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct DeleteViewCase_Previews: PreviewProvider {
    static var previews: some View {
        DeleteViewCase()
    }
}
