//
//  OnPassCodeView.swift
//  PrivateEye
//
//  Created by Mayank Girdhar on 20/06/2021.
//

import Foundation
import SwiftUI

struct OnPassCodeView: View {
    
    @State var passcode: [String] = []
    
    
    
    
    var body: some View {
        VStack{
            Spacer()
            
            Text("Set a 6 Digit Password").font(.title2).fontWeight(.semibold)
            
            HStack{
                ForEach(passcode, id: \.self){ item in
                    
                    Text(item).font(.title).fontWeight(.semibold)
                    
                }
            }.padding(.vertical)
            
            Spacer()
            
            OnNumPad(codes: $passcode)
        }
        .animation(.spring())
    }
}
