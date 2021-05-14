//
//  VideoModel.swift
//  SuperHero
//
//  Created by Mayank Girdhar on 15/04/21.
//

import Foundation

struct Video: Codable, Identifiable {
  let id: String
  let name: String
  let headline: String
  
  // Computed Property
  var thumbnail: String {
    "video-\(id)"
  }
}
