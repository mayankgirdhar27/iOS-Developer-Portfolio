
import Foundation
import Combine
import UIKit

class CountryViewModel: ObservableObject {
    
    @Published var countryResponse = CountryResponse()
    
    private var covidService: CovidService!
    
    init() {
        self.covidService = CovidService()
    }
    
    var activeCases: String{
        let temp0 =  self.countryResponse.Active!
        let temp = String(temp0)
        let temp1 = temp.replacingOccurrences(of: ".0", with: "")
        let temp2 = ""
        if temp0 == 0 {
            return temp2
            
        }else{
            return temp1
        }
    }
    var recovered: String {
        let temp0 =  self.countryResponse.Recovered!
        let temp = String(temp0)
        let temp1 = temp.replacingOccurrences(of: ".0", with: "")
        let temp2 = ""
        if temp0 == 0 {
            return temp2
            
        }else{
            return temp1
        }
    }
    var confirmed: String {
        let temp0 =  self.countryResponse.Confirmed!
        let temp = String(temp0)
        let temp1 = temp.replacingOccurrences(of: ".0", with: "")
        let temp2 = ""
        if temp0 == 0 {
            return temp2
            
        }else{
            return temp1
        }
    }
    var deaths: String {
        let temp0 =  self.countryResponse.Deaths!
        let temp = String(temp0)
        let temp1 = temp.replacingOccurrences(of: ".0", with: "")
        let temp2 = ""
        if temp0 == 0 {
            return temp2
            
        }else{
            return temp1
        }
    }
    var deathRate: String{
        let c = self.countryResponse.Confirmed
        let d = self.countryResponse.Deaths
        let dr = Double((d!/c!)*100)
        let DR = String(format: "%.2f", dr)
        let temp1 = DR.replacingOccurrences(of: "nan", with: "")
        let temp2 = String("\(temp1)")
        let temp3 = ""
        if dr == 0.0{
            return temp3
        }else{
            return temp2
        }
    }
    
    var recoveryRate: String{
        let r = self.countryResponse.Recovered
        let c = self.countryResponse.Confirmed
        let dr = Double((r!/c!)*100)
        let DR = String(format: "%.2f", dr)
        let temp1 = DR.replacingOccurrences(of: "nan", with: "")
        let temp3 = "\(temp1)%"
        if dr == 0.0 {
            return temp3
        }else{
            return temp1
        }
        
    }
    
    var countryName: String = ""
    
    func search() {
        if let country = self.countryName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            let searchedCountry = country.replacingOccurrences(of: " ", with: "-")
            fetchCountryData(by: searchedCountry)
        }
    }
    
    private func fetchCountryData(by country: String) {
        
        self.covidService.fetchData(country: country) { country in
            
            if let countryData = country {
                DispatchQueue.main.async {
                    self.countryResponse = countryData
                }
            }
        }
    }
}
