//
//  MediaView.swift
//  PrivateEye
//
//  Created by Mayank Girdhar on 27/04/21.
//

import SwiftUI
import AVKit

struct MediaView: View {
    
    
    @State private var navigationbarHeight = 0

    @State var addMediaSheet = false
    @StateObject var mediaItems: PickedMediaItem = PickedMediaItem()
    
    @State var url = ""
    @State var description = ""
    @State  var showSheetVideo = false
    @State  var showSheetPhoto = false
    @State var actionSheetMedia = false
    @State var toggleAddMedia: Bool = true
    @State var toggleCancel: Bool = false
    @State var toggleSave: Bool = false
    @State var addMediaMode: Bool = false
    @State var toggleMediaView: Bool = true
    @State var addMediaView: Bool = false
    
    @State var toggleDelete: Bool = false
    @State private var blurDelete = false
    @State var toggleAllMedia: Bool = true
    @State private var toggleNavigation = false
    @State var toggleSaveMode: Bool = false
    

    
    @ObservedObject var folderName = PickedFolderName()
    
    let list: CaseEntity
    let fetchedResults: FetchRequest<SavedMediaEntity>
    init(list: CaseEntity) {
        self.list = list
        self.fetchedResults = FetchRequest<SavedMediaEntity>(fetchRequest: PersistenceProvider.default.savedMediaRequest(for: list))
    }
    
    var body: some View{
        VStack {
            if toggleAllMedia{
            VStack{
                if mediaItems.videos.isEmpty{
                        MediaScrollView(fetchedMedia: fetchedResults.wrappedValue)
                    HStack {
                        Spacer()
                        Button(action: {
                            showSheetVideo = true
                            let convertedInt = Int(list.caseID)
                            folderName.add(item: folderModel(with: convertedInt))
                            
                        }){
                            Label("Add Media", systemImage: "photo.on.rectangle.angled")
                                .font(.system(size: 22))
                        }.padding()
                    }
                }
                
            }
            .animation(.spring())
            }
            if toggleDelete{
                VStack{
                    HStack{
                        Text("Delete Mode").fontWeight(.semibold).font(.system(size: 20)).padding([.leading])
                        Spacer()
                        Button(action: {
//                            withAnimation(.linear(duration: 1.3)) {
                                self.toggleDelete = false
//                                self.blurDelete.toggle()
                                toggleAllMedia.toggle()
//                            }
                            toggleNavigation.toggle()
                        }, label: {
                            Text("Done").fontWeight(.semibold).font(.system(size: 20))
                            
                        }).padding([.trailing])
                    }
                    DeleteMediaView(fetchedMedia: fetchedResults.wrappedValue)
                        .animation(.spring())
                        .cornerRadius(15)
                }
                .cornerRadius(15)
                .padding()

            }
            if toggleAllMedia{
                if !mediaItems.videos.isEmpty{
                    VStack{
                        ScrollView(.horizontal){
                        HStack{
                            ForEach(mediaItems.videos, id: \.id){ item in
                                let checkType = item.url
                                if checkType.contains(".png") || checkType.contains(".jpeg") || checkType.contains(".heic") {
                                    Image(uiImage: UIImage(contentsOfFile: mediaPath1(mediaUrl: (item.url )).path)!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height - (UIScreen.main.bounds.height/4))
                                        .cornerRadius(15)
                                }
                                else if checkType.contains(".mov") || checkType.contains(".mp4"){
                                    VideoPlayer(player: AVPlayer(url: mediaPath1(mediaUrl: checkType)))
                                        .frame(minWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height - (UIScreen.main.bounds.height/4))
                                }
                            }
                        }
                    }
                        TextField("Enter a description ", text: $description)
                            .padding()
                            .textFieldStyle(.roundedBorder)
                        HStack {
                            Button(action: {
                                for item in mediaItems.videos{
                                    PersistenceProvider.default.saveMedia(description: description, url: item.url, in: list)
                                }
                                mediaItems.videos.removeAll()
                            }, label: {
                                HStack {
                                    Image(systemName: "square.and.arrow.down.fill")
                                        .font(.system(size: 18))
                                    Text("Save")
                                        .font(.system(size: 20))
                                }
                        }).padding()
                            Button(action: {
                                for item in mediaItems.videos{
                                    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
                                    guard let targetURL = documentsDirectory?.appendingPathComponent(item.url) else { return }
                                    try? FileManager.default.removeItem(at: targetURL)
                                }
                                mediaItems.videos.removeAll()

                            }, label: {
                                HStack {
                                    Image(systemName: "square.and.arrow.down.fill")
                                        .font(.system(size: 18))
                                    Text("Cancel")
                                        .font(.system(size: 20))
                                }
                            }).padding().foregroundColor(.red)

                            
                        }
                    }
                    .blur(radius: blurDelete ? 50 : 0)
                    .animation(.spring())
                    
                }
            }
            if toggleSaveMode{
                VStack{
                    HStack{
                        Text("Save Mode").fontWeight(.semibold).font(.system(size: 20)).padding([.leading])
                        Spacer()
                        Button(action: {
                            self.toggleSaveMode = false
                            toggleAllMedia.toggle()
                                }, label: {
                                    Text("Done").fontWeight(.semibold).font(.system(size: 20))
                                    
                                }).padding([.trailing])
                    }
                    MediaSaveMode(fetchedMedia: fetchedResults.wrappedValue)
                        .cornerRadius(15)
                        .transition(.slide)
                    
                }.padding()
            }
        }
        
        
        
        .toolbar(content: {
            ToolbarItem(placement: .primaryAction){
                Menu {
                    Section(header: Text("Save Mode")) {
                        Button(action: {
                                toggleAllMedia = false
                                toggleSaveMode = true
                        }) {
                            Label("Save Mode", systemImage: "lock.shield")
                                .foregroundColor(.red)
                        }
                    }
                    Section {
                        Button(action: {
                                toggleDelete = true
                                toggleAllMedia = false
                            }) {
                                Label("Delete Mode", systemImage: "xmark")
                            }
                    }
                }
                label: {
                    Image(systemName: "gear")
                        .font(.system(size: 22))
                    Text("Options")
                }

            }

            
        })
        .navigationBarTitle("Media", displayMode: .inline)
        .navigationViewStyle(StackNavigationViewStyle())
        
        .sheet(isPresented: $showSheetVideo, content: {
                MediaPicker(mediaItems: mediaItems) { didSelectItem in
                showSheetVideo = false}})
            


    }

    func mediaPath1(mediaUrl: String) -> URL{
        let fm = FileManager.default
        let url = try! fm.url (for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let path = url.appendingPathComponent(mediaUrl)
        print(path)
        return path
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(paths)
        return paths[0]
    }
    

}
