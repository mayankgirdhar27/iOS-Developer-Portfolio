//
//  GlobalViewModel.swift
//  Covid19
//
//  Created by Mayank Girdhar on 16/08/20.
//

import Foundation
import Combine

class GLobalViewModel: ObservableObject{
    
    private var globalService: GlobalService!
    
    @Published var global = Global()
    
    init() {
        self.globalService = GlobalService()
    }
    
    var confirmed: String{
        let temp0 = self.global.TotalConfirmed
        let temp1 = String(temp0)
        return temp1
    }
    
}
