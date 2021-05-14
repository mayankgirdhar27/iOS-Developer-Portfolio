//
//  GlobalResponse.swift
//  Covid19
//
//  Created by Mayank Girdhar on 16/08/20.
//

import Foundation

struct GlobalResponse: Decodable {
    let Global: Global
}

struct Global: Decodable{
    let NewConfirmed: Int
    let TotalConfirmed: Int
    let NewDeaths: Int
    let TotalDeaths: Int
    let NewRecovered: Int
    let TotalRecovered: Int
    
    init() {
        self.NewConfirmed = 0
        self.TotalConfirmed = 0
        self.NewDeaths = 0
        self.TotalDeaths = 0
        self.NewRecovered = 0
        self.TotalRecovered = 0
    }
}

