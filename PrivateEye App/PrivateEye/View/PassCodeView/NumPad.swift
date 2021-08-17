//
//  NumPad.swift
//  PrivateEye
//
//  Created by Mayank Girdhar on 20/06/2021.
//

import Foundation
import SwiftUI


struct NumPad: View {
    
    @Environment(\.colorScheme) var colorScheme
    var hapcticImpact = UIImpactFeedbackGenerator(style: .heavy)
    
    @Binding  var codes : [String]
        
    @FetchRequest(fetchRequest: PersistenceProvider.default.requestPassword) var passCode: FetchedResults<Password>
    
    var body: some View {
        
        
        VStack{
                        
            ForEach(PassCodeNumData){ item in
                
                HStack(spacing: self.getSpacing()) {
                    ForEach(item.row) { num in
                        Button(action: {
                            
                            if num.value == "xmark.circle.fill"{
                                self.hapcticImpact.impactOccurred()

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
                                    if passCode.first?.passcode == self.getCode(){
                                        NotificationCenter.default.post(name: NSNotification.Name("Success"), object: nil)
                                        self.codes.removeAll()
                                    }

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
