//
//  SuperheroGridItemView.swift
//  SuperHero
//
//  Created by Mayank Girdhar on 15/04/21.
//
import SwiftUI

struct SuperheroGridItemView: View {
    
    let superhero: SuperHeroModel
    
    var body: some View {
        Image(superhero.image)
            .resizable()
            .scaledToFit()
            .cornerRadius(12)
    }
}

