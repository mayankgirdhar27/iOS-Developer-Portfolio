//
//  PrivateEyeApp.swift
//  PrivateEye
//
//  Created by Mayank Girdhar on 14/05/21.
//

import SwiftUI

@main
struct PrivateEyeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, PersistenceProvider.default.context)
        }
    }
}
