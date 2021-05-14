import Foundation

struct CountryResponse: Decodable{
    
    let Country: String?
    let Confirmed: Double?
    let Deaths: Double?
    let Recovered: Double?
    let Active: Double?
    
    init() {
        self.Country = ""
        self.Confirmed = 0
        self.Active = 0
        self.Recovered = 0
        self.Deaths = 0
    }
}


