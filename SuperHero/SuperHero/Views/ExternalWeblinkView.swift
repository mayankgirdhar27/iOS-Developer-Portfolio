//
//  ExternalWeblinkView.swift
//  SuperHero
//
//  Created by Mayank Girdhar on 15/04/21.
//

import SwiftUI

struct ExternalWeblinkView: View {

  
  let superhero: SuperHeroModel



  var body: some View {
    GroupBox {
      HStack {
        Image(systemName: "globe")
        Text("Source Link")
        Spacer()
        
        Group {
          Image(systemName: "arrow.up.right.square")
          
          Link(superhero.name, destination: (URL(string: superhero.link) ?? URL(string: "https://wikipedia.org"))!)
        }
        .foregroundColor(.accentColor)
      } //: HSTACK
    } //: BOX
  }
}



struct ExternalWeblinkView_Previews: PreviewProvider {
  static let superhero: [SuperHeroModel] = Bundle.main.decode("superhero.json")
  
  static var previews: some View {
    ExternalWeblinkView(superhero: superhero[0])
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
