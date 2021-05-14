//
//  CoverImageView.swift
//  SuperHero
//
//  Created by Mayank Girdhar on 15/04/21.
//

import SwiftUI

struct CoverImageView: View {

  
  let coverImages: [CoverImage] = Bundle.main.decode("covers.json")
  

  
  var body: some View {
    TabView {
      ForEach(coverImages) { item in
        Image(item.name)
          .resizable()
          .scaledToFill()
      } //: LOOP
    } //: TAB
    .tabViewStyle(PageTabViewStyle())
  }
}


struct CoverImageView_Previews: PreviewProvider {
  static var previews: some View {
    CoverImageView()
      .previewLayout(.fixed(width: 400, height: 300))
  }
}
