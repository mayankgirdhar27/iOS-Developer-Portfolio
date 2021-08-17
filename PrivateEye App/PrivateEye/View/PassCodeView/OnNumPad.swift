//
//  OnNumPad.swift
//  PrivateEye
//
//  Created by Mayank Girdhar on 20/06/2021.
//

import Foundation
import SwiftUI

struct OnNumPad: View {
    @Environment(\.colorScheme) var colorScheme
    
    var hapcticImpact = UIImpactFeedbackGenerator(style: .heavy)
    
    @Binding  var codes : [String]
    
    @State var toggleSave = false
    
    @FetchRequest(fetchRequest: PersistenceProvider.default.requestPassword) var passCode: FetchedResults<Password>
    
    @State private var showPassCode = false
    
    
    
    var body: some View {
        
        
        VStack{
            
            
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
                    HStack{
                        Spacer()
                        Button(action: {
                            self.hapcticImpact.impactOccurred()
                            self.hapcticImpact.impactOccurred()

                            PersistenceProvider.default.setPassword(pass: self.getCode())
                            if passCode.first?.passcode == self.getCode(){
                                NotificationCenter.default.post(name: NSNotification.Name("Success"), object: nil)
                                self.codes.removeAll()
                            }
                            
                        }, label: {
                            Text("Save")
                        }).padding().buttonStyle(GradientButtonStyle())
                        Image(systemName: "")
                        Spacer()
                    }
                }
            }
            if self.codes.count < 6{
                ForEach(PassCodeNumData){ item in
                    HStack(spacing: self.getSpacing()) {
                        ForEach(item.row) { num in
                            Button(action: {
                                self.hapcticImpact.impactOccurred()

                                if num.value == "xmark.circle.fill"{
                                    if !codes.isEmpty {
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
            }else if self.codes.count == 6 {
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
        .foregroundColor(colorScheme == .dark ? .white : .black)
        
        
    }
    
    func getSpacing() -> CGFloat{
        return UIScreen.main.bounds.width / 3
    }
    
    func getCode() -> String {
        
        var code = ""
        for item in self.codes{
            code += item
        }
        
        return code
    }
    
}

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(15.0)
    }
}
