//
//  MediaListView.swift
//  PrivateEye
//
//  Created by Mayank Girdhar on 27/04/21.
//

import SwiftUI
import AVKit
import CoreData

struct MediaScrollView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let fetchedMedia: FetchedResults<SavedMediaEntity>
    
    
    @State private var navigationbarHeight = 0
    @State var description = ""
    
    
    
    
    var body: some View {
        GetNavigationBarHeight{ navBar in
            navigationbarHeight = Int(navBar.bounds.height)+300
        } // NAVBAR Height
        
            ScrollView(.horizontal){
            HStack{
                ForEach(fetchedMedia){ item in
                    let checkType = item.url ?? ""
                    if checkType.contains(".png") || checkType.contains(".jpeg") || checkType.contains(".heic") {
                        VStack{
                        Image(uiImage: UIImage(contentsOfFile: mediaPath(mediaUrl: (item.url ?? "")).path)!)
                            .resizable()
                            .cornerRadius(15)
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height - CGFloat(navigationbarHeight))
                            CustomTextField(placeholder: Text("\(item.mediaDescription ?? "")"), text: $description)
                                .padding()
                                .cornerRadius(20)
                                .border(colorScheme == .dark ? .white : .black)
                                
                            Text("\(item.date ?? Date())")
                                .font(.system(size: 12))
                                .multilineTextAlignment(.center)
                        }
                    }
                    else if checkType.contains(".mov") || checkType.contains(".mp4"){
                        VStack{

                        VideoPlayer(player: AVPlayer(url: mediaPath(mediaUrl: checkType)))
                            .frame(minWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height - CGFloat(navigationbarHeight))
                            .cornerRadius(15)
//                            Text(item.mediaDescription ?? "")
                            CustomTextField(placeholder: Text("\(item.mediaDescription ?? "")"), text: $description)
                                .padding()
                                .cornerRadius(20)
                                .border(colorScheme == .dark ? .white : .black)
                            Text("\(item.date ?? Date())")
                                .font(.system(size: 12))
                                .multilineTextAlignment(.center)
                        }

                    }
                }
            }
            .frame(minWidth: UIScreen.main.bounds.width, minHeight: UIScreen.main.bounds.height - CGFloat(navigationbarHeight))
            .padding()
            
        }
        
        .navigationViewStyle(StackNavigationViewStyle())
//        .listStyle(InsetGroupedListStyle()) //List
} //BODY

    
    func mediaPath(mediaUrl: String) -> URL{
        let fm = FileManager.default
        let url = try! fm.url (for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let path = url.appendingPathComponent(mediaUrl)
        print(path)
        return path
    }
    
}

