//
//  All Countries.swift
//  Covid19
//
//  Created by Mayank Girdhar on 11/09/2020.
//

import SwiftUI

struct All_Countries: View {
    
    @State var index = 0
    @State var main:CountryData!
    
    var body: some View {
        List(){
            Text("\(self.main.Countries.count)")
    }
    }
    func getData() {
        
        var url = ""
        
        if self.index == 0{
            url = "https://api.covid19api.com/summary"
        }
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!) {(data, _, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            let decodedData = try! JSONDecoder().decode(CountryData.self, from: data!)
            self.main = decodedData
            print(decodedData)
            
        }
        .resume()
    }
}

struct All_Countries_Previews: PreviewProvider {
    static var previews: some View {
        All_Countries()
    }
}


struct CountryData: Decodable {
    
//    var Global: Globalc
    var Countries: [Country]
    
}

//struct Globalc: Codable {
//    var NewConfirmed: Int
//    var TotalConfirmed: Int
//    var NewRecovered: Int
//    var TotalDeaths: Int
//    var NewDeaths: Int
//    var TotalRecovered: Int
//}

struct Country: Decodable {
    var CountryCode: String
    var Country : String
    var NewConfirmed: Int
    var TotalConfirmed : Int
    var NewDeaths: Int
    var NewRecovered: Int
    var TotalDeaths: Int
    var TotalRecovered: Int
    
    
}
