//
//  ZipView.swift
//  PrivateEye
//
//  Created by Mayank Girdhar on 19/06/2021.
//  

import SwiftUI

struct ZipView: View {
    var body: some View {
        VStack{
            Button {
                zipFolder()
            } label: {
                Text("Save")
            }

        }
    }
    func zipFolder(){
        let fileManager = FileManager.default
        let DirectoryUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        var archiveUrl: URL?
        var error: NSError?

        let coordinator = NSFileCoordinator()
        coordinator.coordinate(readingItemAt: DirectoryUrl, options: [.forUploading], error: &error) { (zipFileURL) in
            let tmpUrl = try! fileManager.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: zipFileURL,
                create: true
            ).appendingPathComponent("folder.zip")
            do{
                try fileManager.copyItem(at: zipFileURL, to: tmpUrl)
            }catch{
                print("Error zipping.")
            }
            print(zipFileURL)
            archiveUrl = tmpUrl
            print(zipFileURL)
        }

        if let zipUrl = archiveUrl {
            let avc = UIActivityViewController(activityItems: [zipUrl], applicationActivities: nil)
        } else {
            print(error)
        }
        
    }
}

struct ZipView_Previews: PreviewProvider {
    static var previews: some View {
        ZipView()
    }
}
