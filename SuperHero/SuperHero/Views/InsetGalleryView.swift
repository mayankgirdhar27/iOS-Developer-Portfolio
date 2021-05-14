

import SwiftUI

struct InsetGalleryView: View {

  
  let superhero: SuperHeroModel
  


  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(alignment: .center, spacing: 15) {
        ForEach(superhero.gallery, id: \.self) { item in
          Image(item)
            .resizable()
            .scaledToFit()
            .frame(height: 200)
            .cornerRadius(12)
        } //: LOOP
      } //: HSTACK
    } //: SCROLL
  }
}


struct InsetGalleryView_Previews: PreviewProvider {
  static let superhero: [SuperHeroModel] = Bundle.main.decode("superhero.json")
  
  static var previews: some View {
    InsetGalleryView(superhero: superhero[0])
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
