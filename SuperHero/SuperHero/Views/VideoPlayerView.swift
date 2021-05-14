//
//  VideoPlayerView.swift
//  SuperHero
//
//  Created by Mayank Girdhar on 15/04/21.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {

  
  var videoSelected: String
  var videoTitle: String



  var body: some View {
    VStack {
        VideoPlayer(player: playVideo(fileName: videoSelected, fileFormat: "mp4")){}
    }
    .navigationBarTitle(videoTitle, displayMode: .inline)
  }
}


struct VideoPlayerView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      VideoPlayerView(videoSelected: "batman", videoTitle: "Batman")
    }
  }
}
