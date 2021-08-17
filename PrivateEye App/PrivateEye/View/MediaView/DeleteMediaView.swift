//
//  DeleteMediaView.swift
//  PrivateEye
//
//  Created by Mayank Girdhar on 19/06/2021.
//

import SwiftUI
import AVKit

struct DeleteMediaView: View {
    
    let fetchedMedia: FetchedResults<SavedMediaEntity>
    
    var body: some View {
        Group {
            VStack{
                List{
                    HStack{
                        Spacer()
                        Text("Swipe left to Delete").fontWeight(.semibold).padding()
                        Image(systemName: "arrow.left")
                        Spacer()
                    }
                    ForEach(fetchedMedia){ item in
                    let checkType = item.url ?? ""
                        VStack{
                            if checkType.contains(".png") || checkType.contains(".jpeg") || checkType.contains(".heic"){
                            HStack {
                                Spacer()
                                Image(uiImage: UIImage(contentsOfFile: mediaPath(mediaUrl: (item.url ?? "")).path)!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxHeight: 300)
                                    .layoutPriority(2)
                                    .cornerRadius(15)
                                Spacer()
                                
                            }
                            }else if checkType.contains(".mov") || checkType.contains(".mp4"){
                                Text(item.url ?? "")
                                VideoPlayer(player: AVPlayer(url: mediaPath(mediaUrl: (item.url ?? ""))))
                                    .frame(minHeight: 300)
                                    .layoutPriority(2)
                                    .cornerRadius(15)

                            }
                            Text("\(item.date ?? Date())").font(.system(size:11))
                        }
                    
                    
                }
                

                .onDelete(perform: { indexSet in
                    PersistenceProvider.default.deleteMedia(fetchedMedia.get(indexSet))
                    print(fetchedMedia)
                    print("HELLOOOOOOOOO")
                })
                .navigationViewStyle(StackNavigationViewStyle())
                
            }
                
            }
        }
    }
    
    func mediaPath(mediaUrl: String) -> URL{
        let fm = FileManager.default
        let url = try! fm.url (for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let path = url.appendingPathComponent(mediaUrl)
        print(path)
        return path
    }
}
