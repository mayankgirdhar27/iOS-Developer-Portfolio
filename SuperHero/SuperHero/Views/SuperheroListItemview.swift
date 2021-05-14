//
//  SuperheroListItemview.swift
//  SuperHero
//
//  Created by Mayank Girdhar on 15/04/21.
//

import SwiftUI

struct SuperheroListItemview: View {
    
    let superhero: SuperHeroModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
          Image(superhero.image)
            .resizable()
            .scaledToFill()
            .frame(width: 90, height: 90)
            .clipShape(
              RoundedRectangle(cornerRadius: 12)
            )
          
          VStack(alignment: .leading, spacing: 8) {
            Text(superhero.name)
              .font(.title2)
              .fontWeight(.heavy)
              .foregroundColor(.accentColor)
            
            Text(superhero.headline)
              .font(.footnote)
              .multilineTextAlignment(.leading)
              .lineLimit(2)
              .padding(.trailing, 8)
          } //: VSTACK
        }
    }
}

struct SuperheroListItemview_Previews: PreviewProvider {
    static let superhero: [SuperHeroModel] = Bundle.main.decode("superhero.json")
    
    static var previews: some View {
        SuperheroListItemview(superhero: superhero[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
