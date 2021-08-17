//
//  NoteView.swift
//  PrivateEye
//  Created by Mayank Girdhar on 20/06/2021.
//

import SwiftUI

struct NoteView: View {
    
    let list: CaseEntity
    let fetchedResults: FetchRequest<SavedMediaEntity>
    init(list: CaseEntity) {
        self.list = list
        self.fetchedResults = FetchRequest<SavedMediaEntity>(fetchRequest: PersistenceProvider.default.savedMediaRequest(for: list))
    }
    
    @State var typeNote = ""
    @State var saveNoteButton: Bool = false
    @State var toggleNote: Bool = true
    @State var editField: Bool = false
    
    var body: some View {
        Form{
            Section(header:
                HStack{
                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
                        .font(.system(size: 22))
                        .foregroundColor(.blue)
                    Text("Notes")
                        .fontWeight(.semibold)
                }
            ){
                if toggleNote{
                    Text("\(list.notes ?? "")")
//                        .onTapGesture {editField = true}
                    Button(action: {
                        editField = true
                        toggleNote = false
                    }, label: {
                        Text("Edit")
//                            .transition(.scale)
                    })
                }
            }
            
//            if editField{
                Section(header: HStack{
                    
                    if editField{
                        Text("Edit Note in the Text Field below")
                    }
                    
            }){
                if editField{
                    TextEditor(text: $typeNote).onTapGesture {
                    typeNote = list.notes ?? ""
                    
                        
                }
                }
            }
//            }
            Section(){
                if !typeNote.isEmpty{
                    Button("Save") {
                        PersistenceProvider.default.editNote(list, change: typeNote)
                        UIApplication.shared.dissmisssKeyboard()
                        typeNote.removeAll()
                        toggleNote = true
                        editField.toggle()
                    }
                }
            }
        }.animation(.spring())
            .navigationViewStyle(StackNavigationViewStyle())
    }
    
}


extension UIApplication {
    func dissmisssKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

