//
//  ContentView.swift
//  SuperHero
//
//  Created by Mayank Girdhar on 15/04/21.
//

import SwiftUI

struct ContentView: View {

  var body: some View {

    TabView{
        MainView()
            .tabItem {
                Image(systemName: "person.crop.square")
                Text("Profiles")
            }
        WatchView()
            .tabItem {
                Image(systemName: "play.tv")
                Text("Watch")
            }
    }
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .previewDevice("iPhone 12 Pro")
  }
}
