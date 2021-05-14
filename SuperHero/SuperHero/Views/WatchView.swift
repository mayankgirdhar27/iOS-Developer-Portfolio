//
//  WatchView.swift
//  SuperHero
//
//  Created by Mayank Girdhar on 15/04/21.
//

import SwiftUI
import AVKit

struct WatchView: View {
    
    @State var videos: [Video] = Bundle.main.decode("videos.json")
    
    let hapticImpact = UIImpactFeedbackGenerator(style: .medium)


    var body: some View {
      NavigationView {
        List {
          ForEach(videos) { item in
            NavigationLink(destination: VideoPlayerView(videoSelected: item.id, videoTitle: item.name)) {
              VideoListItemView(video: item)
                .padding(.vertical, 8)
            }
          } //: LOOP
        } //: LIST
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("Videos", displayMode: .inline)
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
              // Shuffle videos
              videos.shuffle()
              hapticImpact.impactOccurred()
            }) {
              Image(systemName: "arrow.2.squarepath")
            }
          }
        }
      } //: NAVIGATION
    }
}

struct WatchView_Previews: PreviewProvider {
    static var previews: some View {
        WatchView()
    }
}


struct VideoListItemView: View {

  
  let video: Video


  var body: some View {
    HStack(spacing: 10) {
      ZStack {
        Image(video.thumbnail)
          .resizable()
          .scaledToFit()
          .frame(height: 80)
          .cornerRadius(9)
        
        Image(systemName: "play.circle")
          .resizable()
          .scaledToFit()
          .frame(height: 32)
          .shadow(radius: 4)
      } //: ZSTACK
      
      VStack(alignment: .leading, spacing: 10) {
        Text(video.name)
          .font(.title2)
          .fontWeight(.heavy)
          .foregroundColor(.accentColor)
        
        Text(video.headline)
          .font(.footnote)
          .multilineTextAlignment(.leading)
          .lineLimit(2)
      } //: VSTACK
    } //: HSTACK
  }
}


struct VideoListView: View {
  // MARK: - PROPERTIES
  
  @State var videos: [Video] = Bundle.main.decode("videos.json")
  
  let hapticImpact = UIImpactFeedbackGenerator(style: .medium)



  var body: some View {
    NavigationView {
      List {
        ForEach(videos) { item in
          NavigationLink(destination: VideoPlayerView(videoSelected: item.id, videoTitle: item.name)) {
            VideoListItemView(video: item)
              .padding(.vertical, 8)
          }
        }
      }
      .listStyle(InsetGroupedListStyle())
      .navigationBarTitle("Videos", displayMode: .inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: {
            // Shuffle videos
            videos.shuffle()
            hapticImpact.impactOccurred()
          }) {
            Image(systemName: "arrow.2.squarepath")
          }
        }
      }
    }
  }
}
