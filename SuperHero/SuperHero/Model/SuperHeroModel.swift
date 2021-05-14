//
//  SuperHero.swift
//  SuperHero
//
//  Created by Mayank Girdhar on 15/04/21.
//

import Foundation

struct SuperHeroModel: Codable, Identifiable {
  let id: String
  let name: String
  let headline: String
  let description: String
  let link: String
  let image: String
  let gallery: [String]
}
