//
//  ContentView.swift
//  Covid19
//
//  Created by Mayank Girdhar on 05/08/20.
//

import SwiftUI
import Foundation

struct ContentView: View {
    
    @ObservedObject var countryVM: CountryViewModel
    
    init() {
        self.countryVM = CountryViewModel()
    }
    
    var body: some View {
        TabView{
            TodayGlobalCases()
                .tabItem {
                    Image(systemName: "newspaper.fill")
                    Text("Today")
                }
            TotalGlobalCases()
                .tabItem {
                    Image(systemName: "globe")
                    Text("Global")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass.circle.fill")
//                    Image(systemName: "magnifyingglass.circle.fill")
                    Text("Search")
                }

        
        }
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
