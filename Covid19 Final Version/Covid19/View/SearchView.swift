//
//  SearchView.swift
//  Covid19
//
//  Created by Mayank Girdhar on 16/08/20.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var countryVM: CountryViewModel
    
    init() {
        self.countryVM = CountryViewModel()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
                Spacer()
                Text("Search")
                    .font(.largeTitle).fontWeight(.bold).padding()
            TextField("Country Name...", text: self.$countryVM.countryName){self.countryVM.search()}
                    .padding(7)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
                
                VStack(alignment:.center,spacing:20) {
                    HStack(){
                        Text("\(self.countryVM.countryName) ")
                            .font(.system(size: 40))
                            .fontWeight(.medium)
                            .padding(.horizontal)
                        Spacer()
                    }
                    HStack(){
                        Image(systemName: "cross.case.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                        Text("Confirmed cases")
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                        Spacer()
                        Text("\(self.countryVM.confirmed)")
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                    }
                    HStack(){
                        Image(systemName: "waveform.path.ecg")
                            .resizable()
                            .frame(width: 35, height: 35)
                        Text("Active cases")
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                        Spacer()
                        Text("\(self.countryVM.activeCases)")
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                    }
                    HStack(){
                        Image(systemName: "bed.double.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                        Text("Deaths")
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                        Spacer()
                        Text("\(self.countryVM.deaths)")
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                    }
                    HStack(){
                        Image(systemName: "staroflife.circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                        Text("Recoverd")
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                        Spacer()
                        Text("\(self.countryVM.recovered)")
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                    }
                    HStack(){
                        Image(systemName: "waveform.path.ecg.rectangle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                        Text("Death rate")
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                        Spacer()
                        Text("\(self.countryVM.deathRate)")
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                        
                    }
                    VStack(){
                        HStack(){
                            Image(systemName: "staroflife.fill")
                                .resizable()
                                .frame(width: 37, height: 35)
                            
                            Text("Recovery rate")
                                .font(.system(size: 18))
                                .fontWeight(.medium)
                            Spacer()
                            
                            Text("\(self.countryVM.recoveryRate)")
                                .font(.system(size: 18))
                                .fontWeight(.medium)
                        }
                    }
                    // Recovery Rate
                    Spacer()
                }.padding(.all)
            }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
