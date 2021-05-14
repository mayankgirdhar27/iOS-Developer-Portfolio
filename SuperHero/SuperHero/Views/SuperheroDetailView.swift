//
//  SuperheroDetailView.swift
//  SuperHero
//
//  Created by Mayank Girdhar on 15/04/21.
//

import SwiftUI



struct SuperheroDetailView: View {

    let superhero: SuperHeroModel
    
    var body: some View {
      ScrollView(.vertical, showsIndicators: false) {
        VStack(alignment: .center, spacing: 20) {
          // HERO IMAGE
          Image(superhero.image)
            .resizable()
            .scaledToFit()
          
          // TITLE
          Text(superhero.name.uppercased())
            .font(.largeTitle)
            .fontWeight(.heavy)
            .multilineTextAlignment(.center)
            .padding(.vertical, 8)
            .foregroundColor(.primary)
            .background(
              Color.accentColor
                .frame(height: 6)
                .offset(y: 24)
            )
          
          // HEADLINE
          Text(superhero.headline)
            .font(.headline)
            .multilineTextAlignment(.leading)
            .foregroundColor(.accentColor)
            .padding(.horizontal)
          
          // GALLERY
          Group {
            HeadingView(headingImage: "photo.on.rectangle.angled", headingText: "")
            
            InsetGalleryView(superhero: superhero)
          }
          .padding(.horizontal)
          
          // DESCRIPTION
          Group {
            HeadingView(headingImage: "info.circle", headingText: "All about \(superhero.name)")
            
            Text(superhero.description)
              .multilineTextAlignment(.leading)
              .layoutPriority(1)
          }
          .padding(.horizontal)
          
          // MAP

          
          // LINK
          Group {
            HeadingView(headingImage: "books.vertical", headingText: "Learn More")
            
            ExternalWeblinkView(superhero: superhero)
          }
          .padding(.horizontal)
        } //: VSTACK
        .navigationBarTitle("Learn about \(superhero.name)", displayMode: .inline)
      } //: SCROLL
    }}

struct SuperheroDetailView_Previews: PreviewProvider {
    static let superheros: [SuperHeroModel] = Bundle.main.decode("superhero.json")
    
    static var previews: some View {
      NavigationView {
        SuperheroDetailView(superhero: superheros[0])
        
      }
      .previewDevice("iPhone 12 Pro")
    }
}
