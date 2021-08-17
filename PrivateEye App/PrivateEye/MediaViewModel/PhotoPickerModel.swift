//
//  PhotoPickerModel.swift
//  SaveVideo12
//
//  Created by Mayank Girdhar on 05/05/21.
//

import Foundation
import SwiftUI
import Combine
import Photos

struct MediaModel {

    var id : String
    var url : String
    
    init(with media: String) {
        id = UUID().uuidString
        url = media
    }
}

class PickedMediaItem: ObservableObject {
    
   @Published var videos = [MediaModel]()
    
    func add(item: MediaModel) {
        videos.append(item)
    }
    
}

