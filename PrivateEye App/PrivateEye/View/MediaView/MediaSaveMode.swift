//
//  MediaSaveMode.swift
//  PrivateEye
//
//  Created by Mayank Girdhar on 19/06/2021.
//

import SwiftUI
import AVKit

struct MediaSaveMode: View {
    
    let fetchedMedia: FetchedResults<SavedMediaEntity>

    @State var toggleSaved: Bool = false
    @State var showingAlert = false
    
    var hapcticImpact = UIImpactFeedbackGenerator(style: .heavy)
    
    
    var body: some View{
        Group {
            VStack{
            List{
                ForEach(fetchedMedia){ item in
                    let checkType = item.url ?? ""
                    Group{
                        if checkType.contains(".mp4") || checkType.contains(".mov"){
                            HStack{
                                
                                VideoPlayer(player: AVPlayer(url: mediaPath(mediaUrl: (item.url ?? ""))))
                                    .cornerRadius(15)
                                    .frame(width: 200, height: 200)
                                Spacer()
                                Button(action: {
                                    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
                                    guard let targetURL = documentsDirectory?.appendingPathComponent(item.url ?? "") else { return }
                                    let convertedString = targetURL.absoluteString
                                    let convert = convertedString.replacingOccurrences(of:"file://", with: "")
                                    UISaveVideoAtPathToSavedPhotosAlbum(convert, showingAlert = true, nil, nil)
                                    self.hapcticImpact.impactOccurred()
                                    
                                }, label: {
                                    HStack{
                                        Image(systemName: "tray.and.arrow.down.fill")
                                            .font(.system(size: 18))
                                    }
                                }).padding([.horizontal])
                                
                            }
                        }
                        else if checkType.contains(".png") || checkType.contains(".jpeg") || checkType.contains(".heic") {
                            HStack{
                            
                            Image(uiImage: UIImage(contentsOfFile: mediaPath(mediaUrl: (item.url ?? "")).path)!)
                                .resizable()
                                .cornerRadius(15)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200)
                                
                                Spacer()
                            Button(action: {
                                
                                UIImageWriteToSavedPhotosAlbum(UIImage(contentsOfFile: mediaPath(mediaUrl: (item.url ?? "")).path)!, showingAlert = true, nil, nil)
                                self.hapcticImpact.impactOccurred()

                                
                            }, label: {
                                HStack{
                                    Image(systemName: "tray.and.arrow.down.fill")
                                        .font(.system(size: 18))
                                }
                            }).padding([.horizontal])
                            
                        }
                        }
                        
                    }
                    Text("Description: \(item.mediaDescription ?? "")")
                    Text("Date of import: \(item.date ?? Date())")
                        .listStyle(InsetGroupedListStyle())
                }
                .alert(isPresented: $showingAlert){
                    Alert(title: Text("Saved to Photo Library!"),
                          message: Text("Media has been Successfully to the photo library."), dismissButton: .default(Text("OK")))
                }
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


