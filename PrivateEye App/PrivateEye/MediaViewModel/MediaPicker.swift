
import Foundation
import Combine
import CoreData
import SwiftUI
import PhotosUI

struct MediaPicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = PHPickerViewController

    @ObservedObject var mediaItems = PickedMediaItem()
    
    var didFinishPicking: (_ didSelectItems: Bool) -> Void
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .any(of: [.videos, .images])
        config.selectionLimit = 0
        config.preferredAssetRepresentationMode = .current
        
        let controller = PHPickerViewController(configuration: config)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(with: self)
    }
    
    
    class Coordinator: PHPickerViewControllerDelegate {
        var photoPicker: MediaPicker
        
        init(with photoPicker: MediaPicker) {
            self.photoPicker = photoPicker
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            photoPicker.didFinishPicking(!results.isEmpty)
            
            guard !results.isEmpty else {
                return
            }
            
            for result in results {
                let itemProvider = result.itemProvider
                
                guard let typeIdentifier = itemProvider.registeredTypeIdentifiers.first,
                      let utType = UTType(typeIdentifier)
                else { continue }
                if utType.conforms(to: .movie) {
                    self.getMedia(from: itemProvider, typeIdentifier: typeIdentifier)
                }else if utType.conforms(to: .image){
                    self.getMedia(from: itemProvider, typeIdentifier: typeIdentifier)
                }
            }
        }

        private func getMedia(from itemProvider: NSItemProvider, typeIdentifier: String) {
            itemProvider.loadFileRepresentation(forTypeIdentifier: typeIdentifier) { url, error in
                if let error = error {
                    print(error.localizedDescription)
                }
                guard let url = url else { return }
                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
                guard let targetURL = documentsDirectory?.appendingPathComponent(url.lastPathComponent) else { return }
                let ddUrl = documentsDirectory?.path
                let pathURL = targetURL.path
                let finalPath = pathURL.replacingOccurrences(of: ddUrl!, with: "")
                let finalPath1 = finalPath.replacingOccurrences(of: "/", with: "")
                let uniqueString = UUID().uuidString
                let finalString = uniqueString+finalPath1
                guard let finaltargetURL = documentsDirectory?.appendingPathComponent(finalString) else { return }
                
                do {
                    try FileManager.default.copyItem(at: url, to: finaltargetURL)
                    DispatchQueue.main.async {
                        self.photoPicker.mediaItems.add(item: MediaModel(with: finalString))

                        print("This \(finalString) was copied")
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}



struct folderModel{
    var folderId: Int
    
    init(with folder: Int){
        folderId = folder
    }
    
}
class PickedFolderName: ObservableObject{
    @Published var folderName = [folderModel]()
    
    func add(item: folderModel){
        folderName.append(item)
    }
}

//func getFolderName() -> String{
//    @ObservedObject var folderName = PickedFolderName()
//    let convertedInt = Int(fol.folderName.first!.folderId)
//    let finalString = String(convertedInt)
//    return finalString
//}



