//
//  ChangeNumPad.swift
//  PrivateEye
//
//  Created by Mayank Girdhar on 20/06/2021.
//

// Design of this Screen passcode screen was taken from a Youtube video. All the views inside PassCodeView Folder are using the Same Design
// Link to the youtube Video "https://www.youtube.com/watch?v=KPX51BakDe4"

import Foundation
import SwiftUI

struct ChangeNumPad: View {
    
    var hapcticImpact = UIImpactFeedbackGenerator(style: .heavy)
    
    @State  var codes : [String] = []

    @State var toggleSave = false
    
    @Environment(\.colorScheme) var colorScheme
    
    @FetchRequest(fetchRequest: PersistenceProvider.default.requestPassword) var passCode: FetchedResults<Password>
    
    @State private var showPassCode = false
//    @State var toggleNumPad: Bool = true
    @State var toggleNumPad = true
    @State var changePassCode: Bool = true
    @State var afterChange: Bool = false
    @State var newPass: Bool = true
    
    
    
    
    var body: some View {
        
        
        VStack{
            if newPass{
                HStack{
                    Spacer()
                    Text("Enter new Password").font(.title)
                    Spacer()
                }
            }
            
            if afterChange{
                VStack{
                    let converted = passCode.first?.passcode?.replacingOccurrences(of: " ", with: "")
                    Text("Password Changed! to \(converted ?? "")").font(.title3)
                    Text("Swipe Down to go back").font(.callout)
                }
            }
            Spacer()

                HStack{

                    ForEach(codes, id: \.self){ item in
                        Text(item).font(.title).fontWeight(.bold).padding()
                        
                    }
                }.padding(.vertical)
                
            Spacer()
            
            
            
            if codes.count == 6{
                VStack{
                    HStack{
                        Spacer()
                        Text("Please remember this Pass Code.").font(.title2).fontWeight(.semibold)
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        Text("You wont be able to reset the password.").font(.title3)
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        Text("So don't forget it.").font(.title3)
                        Spacer()
                    }
                }
                
                VStack{
                    
                    if changePassCode{
                        HStack{
                        Spacer()
                        Button(action: {
                            self.hapcticImpact.impactOccurred()

                            let fetchedPass = passCode.first!
                            PersistenceProvider.default.editPass(fetchedPass, change: getCode())
                            toggleNumPad.toggle()
                            changePassCode.toggle()
                            afterChange.toggle()
                            newPass.toggle()
                            if passCode.first?.passcode == self.getCode(){
                                NotificationCenter.default.post(name: NSNotification.Name("Success"), object: nil)
                                self.codes.removeAll()
                            }
                            
                        }, label: {
                            Text("Change Password")
                        }).padding().buttonStyle(GradientButtonStyle())
                        Image(systemName: "")
                        Spacer()
                    }
                    }
                }
            }
            if toggleNumPad == true{
                if self.codes.count < 6{
                    ForEach(PassCodeNumData){ item in
                    HStack(spacing: self.getSpacing()) {
                        ForEach(item.row) { num in
                            Button(action: {
                                
                                if num.value == "xmark.circle.fill"{
                                    if !codes.isEmpty {
                                        self.hapcticImpact.impactOccurred()
                                        self.codes.removeLast()
                                    }else if PassCodeNumData.isEmpty{
                                        print("is empty cant remove")
                                    }
                                    
                                }
                                else if num.value == "    "{
                                    print("no Value")
                                }
                                else{
                                    self.hapcticImpact.impactOccurred()
                                    self.codes.append(num.value)
                                    print(codes.count)
                                    
                                    if self.codes.count == 6{
                                        print(self.getCode())
                                        showPassCode = true
                                        toggleSave = true
                                        
                                    }
                                }
                                
                            }) {
                                if num.value == "xmark.circle.fill"{
                                    Image(systemName: num.value).font(.body).padding(.vertical)
                                }else{
                                    Text(num.value).font(.title).fontWeight(.semibold).padding(.vertical)
                                }
                                
                                
                            }
                            
                        }
                    }
                
                
            }
                }
                else if self.codes.count == 6 {
                    ForEach(PassCodeNumData){ item in
                    HStack(spacing: self.getSpacing()) {
                        ForEach(item.row) { num in
                            Button(action: {
                                
                                if num.value == "xmark.circle.fill"{
                                    if !codes.isEmpty {
                                        self.hapcticImpact.impactOccurred()
                                        self.codes.removeLast()
                                    }else if PassCodeNumData.isEmpty{
                                        print("is empty cant remove")
                                    }
                                    
                                }
                                else if num.value == "    "{
                                    print("no Value")
                                }
                                
                            }) {
                                if num.value == "xmark.circle.fill"{
                                    Image(systemName: num.value).font(.body).padding(.vertical)
                                }else{
                                    Text(num.value).font(.title).fontWeight(.semibold).padding(.vertical)
                                }
                                
                                
                            }
                            
                        }
                    }
                
                
            }
                }
            }
        }
        .foregroundColor(colorScheme == .dark ? .white : .black)
        
        
    }
    
    func getSpacing() -> CGFloat{
        var screen = UIScreen.main.bounds.width
        if UIScreen.main.bounds.width > 700 {
            screen = screen / 5
        } else {
            screen = screen / 3
        }
        return screen
    }
    
    func getCode() -> String {
        
        var code = ""
        for item in self.codes{
            code += item
        }
        
        return code
    }
    
}
