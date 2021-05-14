//
//  MainView.swift
//  SuperHero
//
//  Created by Mayank Girdhar on 15/04/21.
//

import SwiftUI

struct MainView: View {

  
  let superheros: [SuperHeroModel] = Bundle.main.decode("superhero.json")
  let haptics = UIImpactFeedbackGenerator(style: .medium)



  var body: some View {


    
    NavigationView {
      Group {
          List {
            CoverImageView()
              .frame(height: 300)
              .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            ForEach(superheros) { hero in
              NavigationLink(destination: SuperheroDetailView(superhero: hero)) {
                SuperheroListItemview(superhero: hero)
              } //: LINK
            } //: LOOP

          } //: LIST

          }
      .navigationBarTitle("Team", displayMode: .large)
        }
      }
}



struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
      .previewDevice("iPhone 12 Pro")
  }
}
