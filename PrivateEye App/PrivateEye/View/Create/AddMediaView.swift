//
//  AddMediaView.swift
//  PrivateEye
//
//  Created by Mayank Girdhar on 31/05/21.
//

import SwiftUI
import AVKit

struct AddMediaView: View {
    
    let caseEntity: CaseEntity
    let fetchedResults: FetchRequest<SavedMediaEntity>
    init(list: CaseEntity) {
        self.caseEntity = list
        self.fetchedResults = FetchRequest<SavedMediaEntity>(fetchRequest: PersistenceProvider.default.savedMediaRequest(for: list))
    }
    
    //    MARK: - Properties
    @State var description = ""
    @State  var showAddMediaSheet = false
    @State var actionSheetMedia = false
    @State var toggleAddMedia: Bool = true
    @State var toggleCancel: Bool = false
    @State var toggleSave: Bool = false
    
    
    @StateObject var mediaItems: PickedMediaItem = PickedMediaItem()
    
    @State var descriptionTextField: Bool = false
    
    
    
    
    //    MARK: - BODY
    var body: some View {
        VStack {
            //            MARK: - Swipe Down Button
            HStack{
                Spacer()
                Image(systemName: "chevron.down").padding([.vertical]).font(.system(size: 30))
                Spacer()
            }
            Spacer()
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
            Spacer()
            if !mediaItems.videos.isEmpty{
                if mediaItems.videos.count > 1{
                    HStack {
                        Image(systemName: "arrow.left.and.right")
                            .font(.system(size: 22))
                        Text("Scroll Horizontally to view all Media")
                            .fontWeight(.semibold)
                            .font(.system(size: 18))
                            
                    }.padding()
                }
                Form{
                    Section(){
                        TextField("Enter a description ", text: $description)
                            .padding()
                    }
                    Section(){
                        cancelSaveButton()
                    }
                }
            }
            if mediaItems.videos.isEmpty{
                Button(action: {
                    showAddMediaSheet = true
                }, label: {
                    Image(systemName: "photo.on.rectangle.angled")
                        .font(.system(size: 18))
                    Text("Add media")
                        .font(.system(size: 20))
                }).padding()
            }
            
        }
        //         MARK: - ShowSheet Video
        .sheet(isPresented: $showAddMediaSheet, content: {
            MediaPicker(mediaItems: mediaItems) { didSelectItem in
                showAddMediaSheet = false
                descriptionTextField = true
            }})
        .navigationViewStyle(StackNavigationViewStyle())
    }
    func mediaPath1(mediaUrl: String) -> URL{
        let fm = FileManager.default
        let url = try! fm.url (for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let path = url.appendingPathComponent(mediaUrl)
        print(path)
        return path
    }
    func mediaPath() -> URL{
        let fm = FileManager.default
        let url = try! fm.url (for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let path = url.appendingPathComponent(getLastItem())
        print(path)
        return path
    }
    
    func getLastItem() -> String{
        let path = mediaItems.videos.last!.url
        return path
    }
    
    func cancelSaveButton() -> some View {
        HStack {
            Button(action: {
                for item in mediaItems.videos{
                    
                    PersistenceProvider.default.saveMedia(description: description, url: item.url, in: caseEntity)
                    
                    
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
            Spacer()
            Button(action: {
                for item in mediaItems.videos{
                    PersistenceProvider.default.saveMedia(description: description, url: item.url, in: caseEntity)
                }
                mediaItems.videos.removeAll()
            }) {
                HStack {
                    Image(systemName: "square.and.arrow.down.fill")
                        .font(.system(size: 22))
                    Text("Cancel")
                        .font(.system(size: 20))
                    
                }.foregroundColor(.red)
            }
            
        }
    }
}


struct GetNavigationBarHeight: UIViewControllerRepresentable {
    var callback: (UINavigationBar) -> Void
    private let proxyController = ViewController()
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<GetNavigationBarHeight>) ->
    UIViewController {
        proxyController.callback = callback
        return proxyController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<GetNavigationBarHeight>) {
    }
    
    typealias UIViewControllerType = UIViewController
    
    private class ViewController: UIViewController {
        var callback: (UINavigationBar) -> Void = { _ in }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if let navBar = self.navigationController {
                self.callback(navBar.navigationBar)
            }
        }
    }
} //NAVBAR HEIGHT
