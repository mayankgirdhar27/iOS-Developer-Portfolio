//
//  PassCodeView.swift
//  PrivateEye
//
//  Created by Mayank Girdhar on 20/06/2021.
//

import Foundation
import SwiftUI


struct PassCodeView: View {
    
    @State var passcode: [String] = []
    
    var body: some View {
        VStack{
            Spacer()
            
            Text("Enter Pass Code").font(.title2).fontWeight(.bold)
            HStack{
                ForEach(passcode, id: \.self){ item in
                    
//                    Text("x").font(.largeTitle).fontWeight(.bold)
                    Image(systemName: "circle.fill").font(.title)
                    
                }
            }.padding(.vertical)
            
            Spacer()
            
            NumPad(codes: $passcode)
        }
//        .animation(.spring())
        .animation(.spring(response: 0.2, dampingFraction: 2, blendDuration: 1.0))
    }
}
