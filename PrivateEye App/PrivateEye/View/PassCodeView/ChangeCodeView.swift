//
//  ChangeCodeView.swift
//  PrivateEye
//
//  Created by Mayank Girdhar on 20/06/2021.
//

import Foundation
import SwiftUI


struct ChangeCodeView: View {
    
    @State var passcode: [String] = []
    
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Image(systemName: "chevron.down").padding(.top).font(.system(size: 30))
                Spacer()
            }
            Spacer()
            
            Spacer()
            
            ChangeNumPad().animation(.spring())
        }
    }
}
